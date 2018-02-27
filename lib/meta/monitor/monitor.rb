
class Monitor
  def initialize(driver, logger)
    @driver = driver
    @logger = logger
    @scalper = Meta::Scalper.new driver
  end

  def scan_catalog; end

  def scan_thread; end

  def loop
    loop do
      boards = ['b', 'mod', 'int', 'an', 'jo', 'lan', 'mu', 'hq', 'tv', 'lit', 'comp', 'cri', 'lang', 'macgyver', 'pfiu', 'coz', 'UF55', '$', 'pol', 'yt', '1997', 'esp', 'high', 'clô', 'escoria', 'pokenanica', '34', 'pr0n', 'tr', 'pinto'].map { |e| "https://55chan.org/#{e}/catalog.html" }
      boards.each do |board|
        try = 5
        begin
          page = scalper.catalog board
          logger.info("Scanning page in #{board} for threads")

          catalog = Meta::Catalog.new page
          logger.info("It was found in #{board} #{catalog.threads.count} threads")

          catalog.threads.each do |t|
            Resque.enqueue(Archive, "https://55chan.org#{t[:href]}")
          end
          break
        rescue Selenium::WebDriver::Error::TimeOutError => e
          Raven.capture_exception(e)
          try -= 1
          retry if try.positive?
        end
        break
      end
      break
      logger.info('Taking a nap')
      sleep(600)
    end
    driver.quit
  end

  def worth?(url)
    /http?s\:\/\/55chan\.org\/(?<board>.+)\/res\/(?<id>\d+)\.html/ =~ url
    board = $LAST_MATCH_INFO[:board]
    id = $LAST_MATCH_INFO[:id]

    if Thread.exist?(board, id)
      false
    else
      true
    end
  end
end
