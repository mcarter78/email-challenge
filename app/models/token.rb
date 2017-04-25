class Token < ActiveRecord::Base
  def self.generate (user)
    puts user
    id = user[:id].to_s
    nonce = id + "_" + SecureRandom.base64
    return nonce
  end

  def self.consume (token)
    puts token
    return token
  end
end
