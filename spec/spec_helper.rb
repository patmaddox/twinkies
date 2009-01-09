require 'rubygems'
require 'spec'
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'twinkies'

DataMapper.setup(:default, 'sqlite3::memory:')

Spec::Runner.configure do |config|
  config.before(:each) { DataMapper.auto_migrate! }
end
