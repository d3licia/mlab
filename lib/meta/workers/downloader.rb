require 'open-uri'

# Simple downloader of files
class Download
  def self.perform(url)
    File.open(File.basename(url).to_s, 'wb') do |dest|
      open(url, 'rb') do |source|
        dest.write source.read
      end
    end
  end
end
