require 'spec_helper'

RSpec.describe Meta::Scalper do
  before(:all) do
    @driver = Meta.driver
  end

  after(:all) do
    @driver.quit
  end

  describe '#catalog' do
    let(:scalper) { Meta::Scalper.new(@driver) }

    it "return catalog page's HTML" do
      page = scalper.catalog 'https://55chan.org/b/catalog.html'
      expect(page).to be_an_instance_of(Nokogiri::HTML::Document)
    end

    it "trow exception if catalog don't show up" do
    end
  end

  describe '#thread' do
    let(:scalper) { Meta::Scalper.new(@driver) }

    it "return catalog page's HTML" do
      page = scalper.catalog 'https://55chan.org/b/catalog.html'
      expect(page).to be_an_instance_of(Nokogiri::HTML::Document)
    end
  end
end
