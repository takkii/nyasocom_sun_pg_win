# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.6'
#ruby '3.4.0-preview2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft'

# javascript next step.
gem 'jsbundling-rails'

# css next step.
gem 'cssbundling-rails'
gem 'font-awesome-sass'

# Use postgresql as the database for Active Record
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma'

# Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# login form
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise-i18n'
gem 'devise-bootstrap-views'
gem 'paranoia'

# pagenate
gem 'dotenv-rails'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'nokogiri'

# markdown
gem 'redcarpet'
gem 'rouge'

# uploads images
gem 'carrierwave'
gem 'rmagick'

# csv
gem 'csv'
gem 'roo'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# two factor
gem 'rotp'
gem 'rqrcode'

# ostruct.rb was loaded from the standard library, but will no longer be part of the default gems starting from Ruby 3.5.0.
gem 'ostruct'

# mail opener
# gem 'letter_opener_web', '~> 2.0'
# gem 'readapt'

# License view

# gem 'license_finder'

group :development, :test do
#   See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
#   gem 'debug', platforms: %i[mri mingw x64_mingw]

#   vscode debug
#   gem 'ruby-debug-ide'
#   gem 'debase'

#   rspec
  gem 'rspec'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'

#   rubocop
#   gem 'rubocop', require: false
#   gem 'rubocop-performance', require: false
#   gem 'rubocop-rails', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Don't delete My Gemfile in Library.
  gem 'listen'
  # gem 'htmlbeautifier'
  # gem 'erb-formatter'
end

group :test do
#   Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
 gem 'capybara'
 gem 'selenium-webdriver'
 gem 'webdrivers'
end

# use windows env
gem 'tzinfo-data' if Gem.win_platform?
gem 'wdm' if Gem.win_platform?
