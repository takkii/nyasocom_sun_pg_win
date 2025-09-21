# frozen_string_literal: true

require 'rbconfig'

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.

max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }

min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }

threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.

worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

begin
  host_os = RbConfig::CONFIG['host_os']
  app_root = File.expand_path("../..", __FILE__)
  case host_os
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    begin
      # Specifies the `port` that Puma will listen on to receive requests; default is 3000.
      port ENV.fetch('PORT') { 80 }
    rescue Exception => e
      puts e.backtrace
    end
  when /darwin|mac os/
    # Docker and Nginx
    bind "unix://#{app_root}/tmp/sockets/puma.sock"
  when /linux/
    # Docker and Nginx
    bind "unix://#{app_root}/tmp/sockets/puma.sock"
  else
    begin
      raise
    rescue Exception => ce
      puts 'Env, UNIX and Windows only. Other OS is Exception.'
    end
  end
rescue StandardError => ex
  puts ex.printStackTrace
rescue Exception => er
  puts er.printStackTrace
ensure
  GC.compact
end

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RAILS_ENV') { 'development' }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
# preload_app!
# Allow puma to be restarted by `bin/rails restart` command.

plugin :tmp_restart
