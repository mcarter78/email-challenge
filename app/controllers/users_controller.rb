class UsersController < ApplicationController
  def create
    # validate that new email does not already exist
    user = User.find(params[:email])
    if user !== nil
      # error
    else
      User.create(user_params)
    end
  end

  def edit
    @user = User.find(params[:email])
  end

  def update
    # validate that updated email does not already exist
    
    # validate that token in params matches a nonce tied to current user email
  end

  def destroy

  end

  private

  def user_params
    params.require(:name, :email)
  end
end
