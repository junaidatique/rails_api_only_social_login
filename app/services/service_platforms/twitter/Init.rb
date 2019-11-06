module ServicePlatforms
  module Twitter
    class Init
      def call
        api_key = Rails.application.credentials[Rails.env.to_sym][:TWITTER_API_KEY]
        secret_key = Rails.application.credentials[Rails.env.to_sym][:TWITTER_SECRET_KEY]
        OAuth::Consumer.new(api_key, secret_key, site: ServicePlatforms::Twitter::Constants::API_URL)
      end
      
    end
  end
end