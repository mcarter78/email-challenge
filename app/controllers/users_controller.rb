class UsersController < BaseController
  def index
    # Send JSON object with all users
    respond_with User.all
  end

  def show
    # Find the user by id in url params
    user = User.find(params[:id])
    # Check for existing tokens belonging to that user
    tokens = Token.find_by(user_id: user[:id])
    # If there are tokens for that user
    if tokens != nil
      # Use the first token
      token = tokens
    else
      # If not, use Token's generate method to create a new token for the user
      token = Token.generate user
    end
    # Build an object to respond with
    response = {
      user: user,
      token: token
    }
    # Send JSON object with user & token info back
    respond_with response, json: response
  end

  def create
    # TODO: Refactor idea - maybe move validations to the model?
    # First, Validate that email submitted does not already exist in DB
    # Find any users in DB with email from form
    users = User.find_by(email: params[:email])
    # If no users match
    if users == nil
      # Create the new user
      new_user = User.create(user_params)
      # Send JSON object with user info
      respond_with new_user, json: new_user
    else
      # If there is a match, send error response
      error_msg = ['Error: Email already exists!']
      respond_with error_msg, json: error_msg
    end
  end

  def edit
    # Find the user by id in url params
    user = User.find(params[:id])
    # Send JSON object with user info
    respond_with user, json: user
  end

  def update
    # TODO: Refactor idea - maybe move validations to the model?
    # First, Validate that email in params is an existing user
    current_user = User.find_by(email: params[:email])
    if current_user != nil
      # Next, Validate that new email submitted does not already exist in DB
      # Find any users in DB with email from form
      users = User.find_by(email: params[:new_email])
      # If no users match
      if users == nil
        # Find the user from id in url params
        user = User.find(params[:id])
        # Call Token's consume method to check and destroy token from query params
        consumed = Token.consume params[:token], current_user[:id]
        # If Token consume was successful
        if consumed != nil
          # Re-assign the email param using the new email -- I DIDN'T THINK THIS WOULD WORK
          params[:email] = params[:new_email]
          # Make the requested changes to the user record
          user.update_attributes(user_params)
          # Send JSON object with updated users info
          respond_with user, json: user
        else
          # If Token consume was unsucessful, send error message
          error_msg = ['Error: Incorrect Token!']
          respond_with error_msg, json: error_msg
        end
      else
        # If new email matches an existing reccord, send error message
        error_msg = ['Error: Email already exists!']
        respond_with error_msg, json: error_msg
      end
    else
      # If email from params does not exist, send error message
      error_msg = ['Error: Invalid email!']
      respond_with error_msg, json: error_msg
    end
  end

  def destroy
    # Find the user by id in url params
    user = User.find(params[:id])
    # Delete the user record
    user.destroy
    # Send JSON object with user info
    respond_with user, json: user
  end

  private

  def user_params
    # Whitelist the params that users are allowed to edit
    params.permit(:name, :email, :marketing, :articles, :digest)
  end
end
