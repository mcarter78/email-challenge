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
    # User.find will throw an error if it does not find the requested record,
    # so I will find all users, then iterate through the returned data to
    # check for any existing email address matches.
    # This would not be a good solution in a large database, and is my
    # first priortity to refactor once the application is fully functional.
    users = User.all
    matches = 0
    for user in users
      if user[:email] == params[:email]
        matches = matches + 1
      end
    end

    if matches == 0
      new_user = User.create(user_params)
      respond_with new_user, json: new_user
    else
      error_msg = ['error']
      respond_with error_msg, json: error_msg
    end
  end

  def edit
    user = User.find(params[:id])
    respond_with user, json: user
  end

  def update
    # VALIDATE THAT THE EMAIL SUBMITTED DOES NOT ALREADY EXIST IN DB
    # User.find will throw an error if it does not find the requested record,
    # so I will find all users, then iterate through the returned data to
    # check for any existing email address matches.
    # This would not be a good solution in a large database, and is my
    # first priortity to refactor once the application is fully functional.
    users = User.all
    matches = 0
    for user in users
      if user[:email] == params[:email]
        matches = matches + 1
      end
    end

    if matches == 0
      user = User.find(params[:id])
      # TODO: validate that token in params matches a nonce tied to current user email

      user.update_attributes(user_params)
      respond_with user, json: user
    else
      error_msg = ['error']
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
