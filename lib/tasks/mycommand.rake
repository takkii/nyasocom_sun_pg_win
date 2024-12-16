require 'date'

namespace :db do
  Onetoday = Date.today
  dump_logs = Dir.mkdir('backup', perm = 0o777) unless FileTest.exist?('backup')
  desc 'Dump the database to backup/today_dbname_backup.dump'
  task pg_dump_backup: %i[environment load_config] do
    dump_logs
    sh "pg_dumpall -U postgres --clean --if-exists --inserts > backup/#{Onetoday}_nyasocom2_backup.dump"
  end

  desc 'Dump the database to tmp/dbname.dump'
  task pg_dump: %i[environment load_config] do
    sh "pg_dump -U postgres nyasocom_beta_development > import/nyasocom_beta_development.dump"
  end

  desc 'Restore the database from tmp/dbname.dump'
  task pg_restore: %i[environment load_config] do
    sh "psql -f import/nyasocom_beta_development.dump -U postgres"
  end

  create_pg = 'CREATE EXTENSION pgroonga;'
  desc 'Create Extension PGroonga'
  task create_pgroonga: %i[environment load_config] do
    sh "psql -U postgres -d nyasocom_beta_development -c #{create_pg}" if ActiveRecord::Base.connection.execute("SELECT * FROM pg_extension WHERE extname = 'pgroonga'").to_a.empty?
  end

  desc 'Dump and reset and restore'
  task pg_dump_reset_restore_seed: %i[environment load_config] do
    Rake::Task['db:pg_dump'].invoke
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:pg_restore'].invoke
    Rake::Task['db:seed'].invoke
  end

  desc 'create and migrate and seed'
  task pg_default_db: %i[environment load_config] do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end

  desc 'Default database command'
  task default_db: %i[environment load_config] do
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
