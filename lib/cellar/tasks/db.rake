namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

namespace :db do
  desc "Create DB"
  task :create, :env do |cmd, args|
    env = args[:env] || "development"
    user = DB_CONFIG[env]['username']
    password = DB_CONFIG[env]['password']
    host = DB_CONFIG[env]['host']
    db = DB_CONFIG[env]['database']
    if user and password
      %x(createdb #{db} -E UTF8 -U #{user} -w #{pw} -h #{host})
    else
      %x(createdb #{db} -E UTF8 -h #{host})
    end
  end

  desc "Drop database"
  task :nuke, :env do |cmd, args|
    env = args[:env] || "development"
    db = DB_CONFIG[env]['database']
    %x(dropdb #{db})
  end

  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    # Rake::Task['environment'].invoke(env)
    Sequel.extension :migration
    Sequel::Migrator.apply(App::DB, Cellar.path('db/migrations'))
  end

  desc 'Seed data'
  task :seed, :env do |cmd, args|
    Dir[File.join(APP_PATH, 'sites/*')].each do |site|
      site_data = YAML.load_file(File.join(site, 'data/site.yml'))
      site_record = Cellar::Site.new name: site.split('/').last
      site_record[:domain] = site_data['domain']
      site_record.save
      YAML.load_file(File.join(site, 'data/pages.yml')).each do |page|
        page_record =Cellar::Page.new(site_id: site_record.id)
        page_record.set_fields page, ['slug', 'template', 'content']
        page_record.save
      end
    end
  end

  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    # Rake::Task['environment'].invoke(env)
    Sequel.extension :migration
    version = (row = App::DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(App::DB, Cellar.path('db/migrations'), version - 1)
  end

  desc "Drop all tables in database"
  task :drop, :env do |cmd, args|
    env = args[:env] || "development"
    # Rake::Task['environment'].invoke(env)
    App::DB.tables.each do |table|
      App::DB.run("DROP TABLE #{table} CASCADE")
    end
  end

  desc "Recreate db from YAMLs"
  task :reset, [:env] => [:drop, :nuke, :create, :migrate, :seed]
end

