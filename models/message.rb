class Message < ActiveRecord::Base
  # self.primary_key :id
  validates :content, presence: true
end
