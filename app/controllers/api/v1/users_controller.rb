class Api::V1::UsersController < ApplicationController

  def create
    @user = User.create(params_user)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: User.find(params[:id])
  end

  private

  def params_user
    params.require(:user).permit(:email, :password)
  end
end
