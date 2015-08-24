require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/task")
require("pg")
require('./lib/list')



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
  list = List.find(id)
  @sorted_tasks = Task.sort(list.id())
  erb(:list)
end

post('/lists/:id') do
  id = params.fetch("id").to_i()
  description = params.fetch("description")
  due_date = params.fetch("due_date")
  task = Task.new({:description => description, :list_id => id, :due_date => due_date})
  task.save()
  list = List.find(id)
  @sorted_tasks = Task.sort(list.id())
  erb(:list)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:task_edit)
end
