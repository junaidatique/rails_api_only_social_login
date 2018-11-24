module Partners
  class Build
    def initialize(partner_platform)
      @partner_platform = partner_platform
    end

    def call
      if @partner_platform == Partners::Constants::SHOPIFY_SLUG
        return Partners::Shopify
      end
    end
  end
end