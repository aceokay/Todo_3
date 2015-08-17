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

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL"})
      task2 = Task.new({:description => "learn SQL"})
      expect(task1).to(eq(task2))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
    test_track = Task.new({:description => "learn SQL"})
    test_track.save()
    expect(Task.all()).to(eq([test_track]))
    end
  end
end
