require('capybara/rspec')
require('./app')
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



end
