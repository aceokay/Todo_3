ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("list")
require("task")
require('pry')
require('date')



RSpec.configure do |config|
  config.after(:each) do
    Task.all().each() do |task|
      task.destroy()
    end
  end
end
