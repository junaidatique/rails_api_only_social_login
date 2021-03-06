module JWTAuth
  class JsonWebToken
    # secret to encode and decode token
    HMAC_SECRET = Rails.application.credentials[Rails.env.to_sym][:secret_key_base]

    def self.encode(payload, exp = 24.hours.from_now)      
      payload[:exp] = exp.to_i            
      text  = JWT.encode(payload, HMAC_SECRET)
      return text
      # len   = ActiveSupport::MessageEncryptor.key_len      
      # salt  = SecureRandom.hex len      
      # key   = ActiveSupport::KeyGenerator.new(HMAC_SECRET).generate_key salt, len      
      # crypt = ActiveSupport::MessageEncryptor.new key
      # encrypted_data = crypt.encrypt_and_sign text      
      # return "#{salt}$$#{encrypted_data}"
    end

    def self.decode(text)      
      # salt, data = text.split "$$"
      # len   = ActiveSupport::MessageEncryptor.key_len      
      # key   = ActiveSupport::KeyGenerator.new(HMAC_SECRET).generate_key salt, len
      # crypt = ActiveSupport::MessageEncryptor.new key
      # token = crypt.decrypt_and_verify data
      # body  = JWT.decode(token, HMAC_SECRET)[0]
      body  = JWT.decode(text, HMAC_SECRET)[0]      
      HashWithIndifferentAccess.new body      
    rescue ActiveSupport::MessageEncryptor::InvalidMessage => e      
      raise JWTAuth::ExceptionHandler::InvalidToken, "Invalid State"
    rescue JWT::DecodeError => e      
      raise JWTAuth::ExceptionHandler::InvalidToken, e.message
    end
  end
end