require 'spec_helper'

RSpec.describe Meta::Catalog do
  let(:page) do
    path = File.expand_path('../../fixtures/catalog.html', __FILE__)
    Nokogiri::HTML(File.open(path))
  end

  describe '#threads' do
    it "get active thread's data" do
      catalog = Meta::Catalog.new(page)
      expect(catalog.threads).to_not be_empty
    end
  end

  describe '::parse_thread' do
    let(:thread) { Meta::Catalog.parse_thread(page.css('div.threads .thread').first) }

    it 'has count replies' do
      expect(thread).to have_key(:replies)
    end

    it "has thread's creation time" do
      expect(thread).to have_key(:time)
    end

    it "has last post's time" do
      expect(thread).to have_key(:bump)
    end

    it "has thread's subject" do
      expect(thread).to have_key(:subject)
    end

    it "contain author's name" do
      expect(thread).to have_key(:name)
    end

    it "has thread's link" do
      expect(thread).to have_key(:href)
    end

    it 'has a partial link to the thread' do
      expect(thread[:href]).to match(/^\/.+\/\d+\.html$/)
    end
  end
end
