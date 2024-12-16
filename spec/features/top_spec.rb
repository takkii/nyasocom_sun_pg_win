require 'rails_helper'
require 'himekurits'

RSpec.feature "Tops", type: :feature do
  scenario 'The locale is displayed on the top page' do
    visit root_path
    expect(page).to have_content "#{HimekuriTsBasicWeb.new.node_running_web_locale}".to_s
  end

  scenario 'Does not contain just one word, himekuri' do
    visit root_path
    expect(page).to have_no_content "#{HimekuriTsBasicWeb.new.node_running_web_himekuri}".to_s
  end
end
