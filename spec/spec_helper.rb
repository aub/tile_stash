require 'rubygems'
gem 'rspec', '~> 1.1'
gem 'sinatra', '~> 0.9.2'

begin
  require 'ruby-debug'
rescue LoadError
  puts 'ruby-debug is not available. Good luck debugging'
end

require 'spec'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'custom_matchers')

require File.join(File.dirname(__FILE__), '..', 'lib', 'tile_stash')

class TestApp < Sinatra::Base
end

def test_app(config)
  TestApp.reset!
  TestApp.get '*' do
    config_file = File.join(File.dirname(__FILE__), 'configs', "#{config}.yml")
    response = TileStash::Stash.new(config_file).handle_request(request)
    content_type(response.content_type)
    response.body
  end
  TestApp
end

