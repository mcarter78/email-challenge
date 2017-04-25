class UsersController < ApplicationController
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
    params.permit(:name, :email)
  end
end
