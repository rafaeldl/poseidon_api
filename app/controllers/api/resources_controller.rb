module Api
  class ResourcesController < ApplicationController

    skip_before_filter :verify_authenticity_token

    before_filter :set_resource_class
    before_filter :load_resources, only: [:index]
    before_filter :set_resource, only: [:show, :edit, :update, :destroy]

    def index
      respond_to do |format|
        format.json { render json: @resources }
      end
    end

    def show
    end

    def create
      @resource = @klazz.new(resource_params)

      respond_to do |format|
        if @resource.save
          format.json { render json: @resource, status: :created }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.update(resource_params)
          format.json { render json: @resource, status: :ok}
        else
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @resource.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    def metadata
      @metadata = Entity.includes(:many_field => :entity).find_by_name(params[:resource])
    end

    def query
      resource = params[:resource]
      # entity = Entity.includes(:field_items).where(:fields => {show_query: true}).find_by_name(resource)
      entity = Entity.includes(:many_field).where(:name => resource, :fields => {show_query: true}).first
      filters = entity.many_field.where(kind: 'string').to_a.delete_if{|field| !@klazz.column_names.include? field.name}.map{|field| "\"#{field.name}\" LIKE :string_search" }
      @fields = [:id]+entity.many_field.map {|f| f.name.to_sym}
      @query = @klazz.select(@fields)
      @query = @query.where(filters.join(' OR '), {string_search: "%#{params['s']}%"}) unless params['s'].blank?
    end

    private

    def set_resource_class
      if params[:resource]

        @resource_sym = params[:resource].to_sym
        @metadata = Entity.includes(:many_field => :entity).find_by_name(params[:resource])
        class_name = params[:resource].capitalize

        if Object.const_defined?(class_name)
          @klazz = Object.const_get(class_name)
        else
          begin
            @klazz = class_name.constantize
          rescue
            # Cria a classe
            @klazz = Object.const_set(class_name, Class.new(ActiveRecord::Base))
            @klazz.table_name = @resource_sym
            @klazz.class_eval do
              metadata = Entity.includes(:many_field => :entity).find_by_name(self.table_name)
              metadata.items.each do |item|
                association = "many_#{item.name}".to_sym
                has_many association, :class_name => item.name.camelize, :foreign_key => "#{self.table_name}_id".to_sym
                accepts_nested_attributes_for association
              end
            end

          end
          @klazz.connection
        end

      end
    end

    def set_resource
      @resource = @klazz.find(params[:id])
    end

    def load_resources
      if @klazz
        @resources = @klazz.all
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      permition = @klazz.attribute_names - [:created_at, :updated_at]
      @metadata.items.each do |entity|
        permition << {"many_#{entity.name}_attributes".to_sym =>
                          [:id] + entity.many_field.map{|field| field.name.to_sym} - [:created_at, :updated_at]}
      end
      params.require(@resource_sym).permit(*permition)
    end

  end
end

