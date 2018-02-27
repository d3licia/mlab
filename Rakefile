require_relative 'config/setup'
require 'resque/tasks'
require 'dotenv/tasks'
require 'standalone_migrations'

StandaloneMigrations::Tasks.load_tasks

task :test do
	RSpec::Core::RakeTask.new(:spec)
  Rake::Task['spec'].invoke
end

task "resque:setup" => :dotenv