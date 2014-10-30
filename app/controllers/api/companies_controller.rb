module Api
  class CompaniesController < ApplicationController
    before_action :set_company, only: [:show, :edit, :update, :destroy]

    # skip_before_filter :verify_authenticity_token
    # skip_before_filter :authenticate_user_from_token!
    skip_before_filter :authenticate_user!, only: [:create]

    # GET /companies
    # GET /companies.json
    def index
      @companies = Company.all

      respond_to do |format|
        format.json { render json: @companies }
      end
    end

    # GET /companies/1
    # GET /companies/1.json
    def show
      respond_to do |format|
        format.json { render json: @company }
      end
    end

    # POST /companies
    # POST /companies.json
    def create

      @company = Company.new(company_params)
      @user = User.new(user_params)

      respond_to do |format|
        if @company.save && @user.save
          format.json { render json: @company, status: :created}
        else
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /companies/1
    # PATCH/PUT /companies/1.json
    def update
      respond_to do |format|
        if @company.update(company_params)
          format.json { render json: @company, status: :ok }
        else
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /companies/1
    # DELETE /companies/1.json
    def destroy
      @company.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_company
        @company = Company.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def company_params
        params.require(:company).permit(:name)
        # params.require(:company).permit(:name, :cnpj, :phone)
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
  end
end