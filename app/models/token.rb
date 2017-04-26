class Token < ActiveRecord::Base
  def self.generate (user)
    # Convert the given id integer to a string
    id = user[:id].to_s
    # Concatenate the id and a random number, joined with an underscore
    nonce = id + "_" + SecureRandom.base64
    # Build a new token object
    token = {
      nonce: nonce,
      user_id: user[:id]
    }
    # Use the token object to create a new token in the DB
    new_token = Token.create(token)
    # return the new token
    return new_token
  end

  def self.consume (nonce)
    # Try to find a matching token object by the nonce given
    token = Token.find_by(nonce: nonce)
    # If token exists
    if token != nil
      # Find the associated user by their id in the token object
      user = User.find_by(id: token[:user_id])
      # Destroy the token
      token.destroy
      # Return the user object
      return user
    else
      # If the token does not exist...
      return nil
    end
  end
end
