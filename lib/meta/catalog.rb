module Meta
  # Parse content from catalog's page.
  class Catalog
    # Use a page load as resource.
    #
    # @param page [Nokogiri::HTML::Document]
    def initialize(page)
      @page = page
    end

    def threads
      unless @threads
        @threads = @page.css('div.threads .thread').map { |t| self.class.parse_thread(t) }
      end
      @threads
    end

    # Get meta data about threads on catalog
    #
    # @param thread Nokogiri::XML::Element
    def self.parse_thread(thread)
      replies = thread.parent['data-reply']
      bump = thread.parent['data-bump']
      time = thread.parent['data-time']
      name = thread.at_css('a > img')['data-name']
      subject = thread.at_css('a > img')['data-subject']
      href = thread.at_css('a:first-child')['href']
      { replies: replies, bump: bump, time: time, name: name, subject: subject, href: href }
    end
  end
end
