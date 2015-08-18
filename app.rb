require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("pg")
require('./lib/list')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end

get('/lists/new') do
  erb(:list_new)
end

post('/lists') do
  name = params.fetch('name')
  @list = List.new({:name => name, :id => nil})
  erb(:success)
end
