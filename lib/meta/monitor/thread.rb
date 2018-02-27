class Thread
  def initialize(args); end

  def exist?(board, _thread)
    Message.where(board: board, thread: id).exist?
  end

  # Calc message per second rate
  def mps(board, _thread, limit = 10)
    dates = Message.select(:timestamp).where(board: board, thread: id).limit(limit).order(timestamp: :desc).map(&:to_i)
    (dates.reduce(:+) / dates.count) - dates.last
  end
end
