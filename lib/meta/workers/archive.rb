class Archive
  @queue = :threads
  
  def self.perform(url)

    ActiveRecord::Base.clear_active_connections!
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

    driver = Meta.driver
    scalper = Meta::Scalper.new(driver)

    begin
      page = scalper.thread url
      thread = Meta::Thread.new(page)

      if thread.valid?
        thread.posts.each do |p|
          Message.create!(id: p.id, email: p.email, subject: p.subject, board: thread.board, name: p.name, content: p.body, thread: thread.op.id, op: (thread.op.id == p.id), timestamp: p.date)
        end
      end
    rescue => e
      Raven.capture_exception(e)
    ensure
      driver.quit
    end
  end
end
