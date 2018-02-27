require 'date'

module Meta
  # A facade to post's HTML element.
  class Post
    # Create
    # @params post [Nokogiri::HTML::Element]
    def initialize(post)
      @post = post
    end

    # Get post's id
    #
    # @return [String] post's id
    def id
      # @post['id'].match(/\d+/).to_s
      @post.at_css('p.intro a.post_anchor')[:id]
    end

    # Get post's subject
    #
    # @return [String] post's id
    def subject
      node = @post.at_css('p.intro label span.subject')
      node ? node.text : ''
    end

    # Get post's content
    #
    # @return [String] post body
    def body
      @post.at_css('div.body').text
    end

    # Get post author's email
    #
    # @return [String] post's id
    def email
      node = @post.at_css('p.intro label a.email')
      node ? node[:href] : ''
    end

    # Get post's date
    #
    # @return [Date] when the post was created
    def date
      DateTime.iso8601(@post.at_css('p.intro label time')[:datetime])
    end

    # Get post's author name
    #
    # @return [String] author's name
    def name
      @post.at_css('p.intro label span.name').text
    end

    # Get info about files in post.
    #
    # @return [Array<Hash>] all images found each in a hash with `name`, `href` and `size`.
    def files
      return [] if (files = @post.css('div.files > div.file'))
      files.map do |f|
        name = f.at_css('p.fileinfo > a').text
        href = f.at_css('p.fileinfo > a')[:href]
        size = f.at_css('p.fileinfo > span.imgInfo').text
        { name: name, href: href, size: size }
      end
    end
  end

  # A handler for get structured data from thread's page
  #
  class Thread
    # Create a new thread's handler.
    #
    # @params page [Nokogiri::HTML::Document]
    def initialize(page)
      @page = page
    end

    # Get thread's id
    #
    # @return [String] id
    def id
      @page.at_css('form > input[type=hidden][name=thread]')['value']
    end

    # Get thread's board name.
    #
    # @return [String] board name
    def board
      @page.at_css('form > input[type=hidden][name=board]')['value']
    end

    # All post from catalog page.
    #
    # @return post [Array<Post>]
    def posts
      @posts ||= @page.css('form > div > div.post.reply').map { |p| Post.new(p) } << op
    end

    # Special method to build the OP's post because its data has
    # a different structure.
    def op
      return @op if @op
      post = @page.at_css('form > div > div.post.op')
      # TODO: Detect and handle the case when message have a file or video.
      post << @page.at_css("form > div#thread_#{id} > div.files") if @page.at_css("form > div#thread_#{id} > div.files")
      post << @page.at_css("form > div#thread_#{id} > div.video-container") if @page.at_css("form > div#thread_#{id} > div.video-container")
      post.at_css('p.intro') << @page.at_css("form > div#thread_#{id} > a.post_anchor")
      (@op = Post.new(post))
    end

    # TODO: fix english
    # Protection aginst not found page and
    # orther server and resquet errors.
    def valid?
      !@page.at_css('form > div > div.post').nil?
    end
  end
end
