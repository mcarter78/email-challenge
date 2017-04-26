class UsersController < BaseController
  def index
    respond_with User.all
  end

  def show
    user = User.find(params[:id])
    token = Token.generate user
    response = {
      user: user,
      token: token
    }
    respond_with response, json: response
  end

  def create
    # VALIDATE THAT THE EMAIL SUBMITTED DOES NOT ALREADY EXIST IN DB
    users = User.find_by(email: params[:email])
    if users == nil
      new_user = User.create(user_params)
      respond_with new_user, json: new_user
    else
      error_msg = ['Error: Email already exists!']
      respond_with error_msg, json: error_msg
    end
  end

  def edit
    user = User.find(params[:id])
    respond_with user, json: user
  end

  def update
    # VALIDATE THAT THE EMAIL SUBMITTED DOES NOT ALREADY EXIST IN DB
    users = User.find_by(email: params[:email])
    if users == nil
      user = User.find(params[:id])
      # TODO: validate that token in params matches a nonce tied to current user email
      consumed = Token.consume params[:token]
      if consumed != nil
        user.update_attributes(user_params)
        respond_with user, json: user
      else
        error_msg = ['Error: Incorrect Token!']
        respond_with error_msg, json: error_msg
      end
    else
      error_msg = ['Error: Email already exists!']
      respond_with error_msg, json: error_msg
    end

  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    respond_with user, json: user
  end

  private

  def user_params
    params.permit(:name, :email, :marketing, :articles, :digest)
  end
end
