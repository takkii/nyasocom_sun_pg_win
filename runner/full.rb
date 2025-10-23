# frozen_string_literal: true

# --------------------------------------
# minitest / TDD.
require 'minitest'
require 'minitest/autorun'
require 'minitest/unit'
# --------------------------------------
# dependency library other
require 'rbconfig'
# --------------------------------------
# dependency library myself
require 'bmi'
require 'tanraku'
# --------------------------------------
# minitest-runner
require 'minitest/full_runner'
# --------------------------------------
# Ignore rubygems.
#require 'simplecov'
# --------------------------------------

# The new instance will be deleted after process ends.
class MiniTestFile
  attr_reader :mini_test, :mini_unit

  def initialize
    encoding_style
    host_os = RbConfig::CONFIG['host_os']
    case host_os
    when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
      begin
        # Full, Switch ON / (true, string, string).
        @mini_test = Full(true, "#{Dir.home}".to_s, '/GitHub/nyasocom_sun_pg_win/unit')
      rescue
        tanraku_execute
      end
    when /darwin|mac os/
      # Don't have Macintosh PC.
    when /linux/
      begin
        # FullW, Switch ON / (true, string, string).
        @mini_test = FullW(true, '/mnt/c/Users/sudok', '/GitHub/nyasocom_sun_pg_win/unit')
      rescue
        tanraku_execute
      end
    else
      begin
        raise
      rescue
        puts 'Env, UNIX and Windows only. Other OS is Exception.'
        tanraku_execute
      end
    end
  end

  def remove
    remove_instance_variable(:@mini_test)
  end
end

# Coverage, Start 'SimpleCov.start' add.
begin
  MiniTestFile.new.remove
rescue
  puts 'Tanraku_VERSION: '.to_s + Tanraku::VERSION
  tanraku_execute
ensure
  GC.compact
end

__END__
