require_relative '../config/setup'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  ActiveRecord::Base.establish_connection(eval(ENV['DATABASE_ARGS']) || ENV['DATABASE_URL'])
  ActiveRecord::Migration.maintain_test_schema!
end
