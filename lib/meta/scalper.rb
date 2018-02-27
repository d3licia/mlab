# module Meta
#   # Extract data from pages
#   class Scalper
#     # Create a client to extrat data from site
#     #
#     # param driver [Selenium::WebDriver]
#     def initialize(driver)
#       @driver = driver
#     end

#     # Load HTML page from some
#     #
#     # @param url [String] a url to a catalog page
#     # @return [Nokogiri::HTML]
#     def catalog(url)
#       @driver.navigate.to url
#       wait = Selenium::WebDriver::Wait.new(timeout: 60)
#       wait.until do
#         begin
#           @driver.find_element(css: 'div.threads').displayed?
#         rescue Selenium::WebDriver::Error::NoSuchElementError
#           retry
#         end
#       end
#       Nokogiri::HTML(@driver.page_source)
#     end

#     # Load a thread by URL
#     #
#     # @param url [Integer] a url to a thread
#     # @return [Nokogiri::HTML]
#     def thread(url)
#       @driver.navigate.to url
#       wait = Selenium::WebDriver::Wait.new(timeout: 60)
#       wait.until do
#         begin
#           @driver.find_element(css: "div#thread_#{url.scan(/\d+/).last}").displayed?
#         rescue Selenium::WebDriver::Error::NoSuchElementError
#           retry
#         end
#       end
#       Nokogiri::HTML(@driver.page_source)
#     end
#   end
# end


module Meta
  # Extract data from pages
  class Scalper
    # Create a client to extrat data from site
    #
    # param driver [Selenium::WebDriver]
    def initialize(driver)
      @driver = driver
    end

    # Load HTML page from some
    #
    # @param url [String] a url to a catalog page
    # @return [Nokogiri::HTML]
    def catalog(url)
      @driver.navigate.to url
      page_loaded?(@driver, 'div.threads')
      Nokogiri::HTML(@driver.page_source) # if page_loaded?(@driver, 'div.threads')
    end

    # Load a thread by URL
    #
    # @param url [Integer] a url to a thread
    # @return [Nokogiri::HTML]
    def thread(url)
      @driver.navigate.to url
      page_loaded?(@driver, "div#thread_#{url.scan(/\d+/).last}")
      Nokogiri::HTML(@driver.page_source) # if page_loaded?(@driver, "div#thread_#{url.scan(/\d+/).last}")
    end

    private

    def page_loaded?(driver, element, timeout = 60, interval = 2)
      wait = Selenium::WebDriver::Wait.new(timeout: timeout, interval: interval)
      begin
        wait.until { driver.find_element(css: element).displayed? }
      rescue Selenium::WebDriver::Error::TimeOutError
        # TODO: log this exeption
        # Meta.logger.info("In page ")
        return
      end
      true
    end
  end
end
