require 'spec_helper'

RSpec.describe Meta::Post do
  let!(:post) do
    path = File.expand_path('../../fixtures/post.html', __FILE__)
    page = Nokogiri::HTML(File.open(path), nil, 'UTF-8')
    Meta::Post.new(page.at_css('div'))
  end

  let!(:post) do
    path = File.expand_path('../../fixtures/thread.html', __FILE__)
    page = Nokogiri::HTML(File.open(path))
    Meta::Thread.new(page).op
  end

  describe '#id' do
    it "get post's id" do
      expect(post.id).to eq('21113175').or eq('20292867')
    end
  end

  describe '#body' do
    it "get post's content" do
      expect(post.body).to_not be_empty
    end
  end

  describe '#date' do
    # it "get post's date" do
    #   expect(post.date.strftime('%s')).to eq('21113175').or eq('1486314113')
    # end

    it 'be a DateTime' do
      expect(post.date).to be_an_instance_of DateTime
    end
  end

  describe '#name' do
    it "get author's name" do
      expect(post.name).to eq 'Anônimo'
    end
  end

  describe '#files' do
    it 'get files attach to post' do
      expect(post.files).to_not be_empty
    end

    describe "each post's file" do
      let!(:file) { post.files.first }

      it "have file's name" do
        expect(file).to have_key(:name)
      end

      it "have file's url" do
        expect(file).to have_key(:href)
      end

      it "have file's size" do
        expect(file).to have_key(:size)
      end
    end
  end
end

RSpec.describe Meta::Thread do
  let(:page) do
    Nokogiri::HTML(File.open(File.expand_path('../../fixtures/thread.html', __FILE__)))
  end

  describe '#posts' do
    it 'get posts from thread' do
      thread = Meta::Thread.new(page)
      expect(thread.posts).to_not be_empty
    end
  end

  describe '#id' do
    it "get thread's id" do
      thread = Meta::Thread.new(page)
      expect(thread.id).to eq('21113175')
    end
  end

  describe '#board' do
    it "get thread's board name" do
      thread = Meta::Thread.new(page)
      expect(thread.board).to eq('b')
    end
  end

  describe '#op' do
    it "get OP's post" do
      thread = Meta::Thread.new(page)
      expect(thread.op).to be_an_instance_of Meta::Post
    end
  end
end
