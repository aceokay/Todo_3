require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions,false)

describe('to do app',{:type => :feature}) do

  describe('adding a new list') do
    it('allows a user to click a list to see the tasks and details for it') do
      visit('/')
      click_link('Add New List')
      fill_in('name',:with => 'Epicodus Work')
      click_button('Add List')
      expect(page).to have_content('Success!')
    end
  end

  describe('viewing all lists') do
    it('allows a user to view all lists') do
      list = List.new({:name => 'Test List', :id => nil})
      list.save()
      visit('/')
      click_link('View All Lists')
      expect(page).to have_content(list.name())
    end
  end

  describe('view a specific list') do
    it('allows the users to click on a specific list and view the details associated to it') do
      list = List.new({:name => 'Test List', :id => nil})
      list.save()
      visit('/lists')
      click_link(list.name)
      expect(page).to have_content(list.name())
    end
    it('greets the users with a message if list has no tasks') do
      list = List.new({:name => 'Bon Giovis List of Things', :id => nil})
      list.save()
      visit("/lists/#{list.id}")
      expect(page).to have_content("You have no tasks in this list")
    end
    it('allows the users to view tasks in a specific list') do
      list = List.new({:name => 'Bon Giovis List of Things', :id => nil})
      list.save()
      task = Task.new({:description => 'Rock Out', :list_id => list.id(), :due_date => Date.new(2015,1,2)})
      task.save()
      visit("/lists/#{list.id}")
      expect(page).to have_content(task.description())
    end
    it('allows the user to add a task to a specific list') do
      list = List.new({:name => 'Bon Giovis List of Things', :id => nil})
      list.save()
      visit("/lists/#{list.id}")
      fill_in('description',:with => 'Do the dishes')
      fill_in('due_date', :with => Date.parse('2016-02-03'))
      click_button('Add Task')
      expect(page).to have_content('Do the dishes')
      expect(page).to have_content('2016-02-03')
    end
  end



end
