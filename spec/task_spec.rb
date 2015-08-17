require("spec_helper")


DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do

  describe(".all") do
    it('is empty at first') do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe('#list_id') do
    it('lets you read the list ID out') do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1})
      task2 = Task.new({:description => "learn SQL", :list_id => 2})
      expect(task1).to(eq(task2))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
    test_track = Task.new({:description => "learn SQL", :list_id => 1})
    test_track.save()
    expect(Task.all()).to(eq([test_track]))
    end
  end

  describe("#sort") do
    it('sorts table by due date') do
      task1 = Task.new({:description => "COOL", :list_id => 1, :due_date => '2017-01-01'})
      task1.save()
      task2 = Task.new({:description => "COO0L", :list_id => 2, :due_date => '2016-01-01'})
      task2.save()
      expect(Task.all().sort()).to(eq([task2, task1]))
    end
  end
end
