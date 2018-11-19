module JWTAuth
  class JsonWebToken
    # secret to encode and decode token
    HMAC_SECRET = Rails.application.credentials[Rails.env.to_sym][:secret_key_base]

    def self.encode(payload, exp = 24.hours.from_now)
      # set expiry to 24 hours from creation time
      payload[:exp] = exp.to_i      
      # sign token with application secret
      text = JWT.encode(payload, HMAC_SECRET)      

      len   = ActiveSupport::MessageEncryptor.key_len      
      salt  = SecureRandom.hex len
      key   = ActiveSupport::KeyGenerator.new(Rails.application.credentials[Rails.env.to_sym][:secret_key_base]).generate_key salt, len      
      crypt = ActiveSupport::MessageEncryptor.new key
      encrypted_data = crypt.encrypt_and_sign text      
      return "#{salt}$$#{encrypted_data}"
    end

    def self.decode(text)
      # get payload; first index in decoded Array
      salt, data = text.split "$$"
      len   = ActiveSupport::MessageEncryptor.key_len
      key   = ActiveSupport::KeyGenerator.new(Rails.application.credentials[Rails.env.to_sym][:secret_key_base]).generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new key
      token = crypt.decrypt_and_verify data
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
      # rescue from all decode errors
    rescue JWT::DecodeError => e
      # raise custom error to be handled by custom handler
      raise JWTAuth::ExceptionHandler::InvalidToken, e.message
    end
  end
end