// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import jquery from "jquery";
window.$ = jquery
import {} from "jquery-ujs";
import {} from "audiojs";
import '@fortawesome/fontawesome-free/js/all';

import Rails from '@rails/ujs';
Rails.start();
