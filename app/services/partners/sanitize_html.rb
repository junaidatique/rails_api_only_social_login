module Partners
  class SanitizeHtml
    def initialize(html)
      @html  = html
    end
    def call
      new_html = @html.gsub("\n", '')
                      .gsub('</p>', "</p>\n")
                      .gsub('<br />', "<br />\n")
                      .gsub('<br />', "<br />\n")
                      .gsub('<li>', "➤ ")
      
      text = ActionController::Base.helpers.strip_tags(new_html)
      return text
    end
  end

end