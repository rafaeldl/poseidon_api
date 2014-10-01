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
      respond_to do |format|
        format.json { render json: @resource }
      end
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
      @metadata = Entity.includes(:fields => :entity).find_by_name(params[:resource])
    end

    def query
      resource = params[:resource]
      entity = Entity.includes(:fields).where(:fields => {show_query: true}).find_by_name(resource)
      filters = entity.fields.where(kind: 'string').to_a.delete_if{|field| !@klazz.column_names.include? field.name}.map{|field| "\"#{field.name}\" LIKE :string_search" }
      @fields = [:id]+entity.fields.map {|f| f.name.to_sym}
      @query = @klazz.select(@fields)
      @query = @query.where(filters.join(' OR '), {string_search: "%#{params['s']}%"}) unless params['s'].blank?
    end

    private

    def set_resource_class
      if params[:resource]
        @resource_sym = params[:resource].to_sym
        @klazz = params[:resource].capitalize.constantize
        @klazz.connection
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
      params.require(@resource_sym).permit(@klazz.attribute_names)
    end

  end
end

