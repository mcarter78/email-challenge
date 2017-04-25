class UsersController < BaseController
  def index
    respond_with User.all
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
      # TODO: THIS NEEDS TO BE FIXED, RETURNS "Unexpected 'e'"
      error_msg = String.new('error')
      respond_with error_msg, json: error_msg
    end
  end

  def edit
    @user = User.find(params[:email])
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
      user.update_attributes(user_params)
      respond_with user, json: user
    else
      # TODO: THIS NEEDS TO BE FIXED, RETURNS "Unexpected 'e'"
      error_msg = String.new('error')
      respond_with error_msg, json: error_msg
    end

    # validate that token in params matches a nonce tied to current user email
  end

  def destroy

  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
