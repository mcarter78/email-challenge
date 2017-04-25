class UsersController < ApplicationController
  def create
    User.create(user_params)
  end

  def edit
    @user = User.find(params[:email])
  end

  def update

  end

  def destroy

  end

  private

  def user_params
    params.require(:name, :email)
  end
end
