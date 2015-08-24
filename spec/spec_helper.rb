ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("list")
require("task")
require('pry')
require('date')



RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM lists *;")
    DB.exec("DELETE FROM tasks *;")
  end
end
