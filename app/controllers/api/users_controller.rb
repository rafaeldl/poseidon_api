module Api
  class UsersController < ApplicationController

    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    # GET /users.json
    def index
      @users = User.all

      respond_to do |format|
        format.json { render json: @users }
      end
    end

    # GET /users/1
    # GET /users/1.json
    def show
      respond_to do |format|
        format.json { render json: @user }
      end
    end

    # POST /users
    # POST /users.json
    def create

      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.json { render json: @user, status: :created }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /users/1
    # PUT /users/1.json
    def update
      # Retira os campos de senha, caso não informados.
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      respond_to do |format|
        if @user.update_attributes(user_params)
          format.json { render json: @user, status: :ok }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url, notice: 'Usuário apagado com sucesso.' }
        format.json { head :no_content }
      end
    end

    def query
      @users = User.where('email LIKE :query', query: "%#{params[:s]}%")

      respond_to do |format|
        format.json { render json: @users }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end

  end
end