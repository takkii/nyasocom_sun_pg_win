require 'rails_helper'

RSpec.feature "Tops", type: :feature do
  scenario 'The locale is displayed on the top page' do
    visit root_path
    expect(page).to have_content "#{HimekuriTsBasicWeb.new.node_running_web_locale}".to_s
  end
end
