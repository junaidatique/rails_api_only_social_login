module ServicePlatforms
  module Auth
    class AuthResponse

      def initialize code
        @code = code
      end
      

      # Used to authenticate app with facebook user
      # Usage
      #   Omniauth::Facebook.authenticate('authorization_code')
      # Flow
      #   Retrieve access_token from authorization_code
      #   Retrieve User_Info hash from access_token
      # def call()        
      #   access_token = selft.get_access_token(@code)
      #   # user_info    = provider.get_user_profile(access_token)
      #   # return user_info, access_token
      #   return access_token
      # end

      # Used to revoke the application permissions and login if a user
      # revoked some of the mandatory permissions required by the application
      # like the email
      # Usage
      #    Omniauth::Facebook.deauthorize('user_id')
      # Flow
      #   Send DELETE /me/permissions?access_token=XXX
      def self.deauthorize(access_token)
        options  = { query: { access_token: access_token } }
        response = self.delete("#{ServicePlatforms::Facebook::Constnt::API_URL}me/permissions", options)

        # Something went wrong most propably beacuse of the connection.
        unless response.success?
          Rails.logger.error 'Omniauth::Facebook.deauthorize Failed'
          fail Omniauth::ResponseError, 'errors.auth.facebook.deauthorization'
        end
        response.parsed_response
      end

      def call()
        puts @code.inspect
        puts query(@code).inspect
        response = HTTParty.get("#{ServicePlatforms::Facebook::Constnt::API_URL}oauth/access_token", query(@code))
        puts response.inspect
        # Something went wrong either wrong configuration or connection
        unless response.success?
          Rails.logger.error 'Omniauth::Facebook.get_access_token Failed'
          # fail Omniauth::ResponseError, 'errors.auth.facebook.access_token'
        end
        response.parsed_response['access_token']
      end

      # def get_user_profile(access_token)
      #   options = { query: { access_token: access_token } }
      #   response = self.class.get('/me', options)

      #   # Something went wrong most propably beacuse of the connection.
      #   unless response.success?
      #     Rails.logger.error 'Omniauth::Facebook.get_user_profile Failed'
      #     fail Omniauth::ResponseError, 'errors.auth.facebook.user_profile'
      #   end
      #   response.parsed_response
      # end

      private
      def query(code)
        {
          query: {
            code: code,
            redirect_uri: "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}oauth/facebook",
            client_id: Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID],
            client_secret: Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET]
          }
        }
      end
    end
  end
end
