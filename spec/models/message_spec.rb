require 'spec_helper'

# Replace a key value with blank or random string
def repl(h, w, *t)
  with = { blank: '', lorem: Faker::Lorem }
  h.each { |k, v| h[k] = t.include?(k) ? with[w] : v }
end

RSpec.describe Message do
  let(:post) { build(:message) }

  describe '.new' do
    it 'create a new user' do
      puts post
      u = Message.new(post)
      expect(u.save).to be true
    end

    it 'validates username presence' do
      u = Message.new(repl(post, :blank, :content))
      expect { u.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'validates password presence' do
      u = Message.new(repl(post, :blank, :content))
      expect { u.save! }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
