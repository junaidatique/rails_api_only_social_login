module Partners
  module Shopify
    class CreateThumbnailUrl
      def initialize(image_url)
        @image_url  = image_url        
      end
      def call
        thumbnail_url = nil
        accepted_formats = [".jpg", ".jpeg", ".png"]
        ext = File.extname(@image_url).split("?").first
        if accepted_formats.include? ext
          src = @image_url.split(ext)
          thumbnail_url = "#{src[0]}_small#{ext}#{src[1]}"
        end
        thumbnail_url
      end
    end
  end
end