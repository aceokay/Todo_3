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
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:success)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

get('/lists/:id') do
  id = params.fetch("id").to_i()
  @list = List.find(id)
  erb(:list)
end
