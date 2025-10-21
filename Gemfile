# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 3.3.6'

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

# html tag delete
gem 'sanitize'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# The default gems starting from Ruby 3.5.0.
gem 'ostruct'

# This Tools is used nyasocom_sun_pg_win.
gem 'grouse'

group :development, :test do
  #   rspec
  gem 'rspec'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.9', '>= 3.9.1'
  gem 'spring-commands-rspec'
  gem 'capybara'

  #   rubocop
  #   gem 'rubocop', require: false
  #   gem 'rubocop-performance', require: false
  #   gem 'rubocop-rails', require: false

  # Use,Windows ENV | other os.
  if Gem.win_platform?
    gem 'sheltered-girl', '4.0.4.5'
    gem 'tzinfo-data'
    gem 'wdm'
  else
    gem 'sheltered-girl'
  end
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Don't delete My Gemfile in Library.
  gem 'listen'
  # gem 'htmlbeautifier'
  # gem 'license_finder'
end

group :test do
  #   Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem 'capybara'
  # gem 'webdrivers'
  # gem 'debug'
end
