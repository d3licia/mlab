require 'rubygems'
require 'toml-rb'

ROOT_DIR = File.expand_path('../', __dir__)

# Load env file
require 'dotenv'
Dotenv.load("#{ROOT_DIR}/.env")

# Default envolment
RUBY_ENV = ENV['RAILS_ENV'] = ENV['RUBY_ENV'] ||= 'development'

# Load gems
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
require 'bundler/setup'
Bundler.require(:default, RUBY_ENV)

# Setup Resque
if ENV['REDIS_URL']
  Resque.redis = Redis.new(url: ENV['REDIS_URL'])
else
  config = YAML.load(File.open("#{ROOT_DIR}/config/redis.yml"))[RUBY_ENV]
  Resque.redis = Redis.new(config)
end

# Setup Database
unless ENV['DATABASE_URL']
  # TODO: build DATABASE_URL from params in file
  ENV['DATABASE_ARGS'] = YAML.load(File.open("#{ROOT_DIR}/config/database.yml"))[RUBY_ENV].to_s
end

# Setup Logger
#TUDO: Setup Logger

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Load app files
["#{ROOT_DIR}/lib/*.rb", "#{ROOT_DIR}/lib/meta/workers/*.rb", "#{ROOT_DIR}/models/*.rb"].each { |d| Dir[d].each { |f| require f } }
