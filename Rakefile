require './lib/cellar.rb'

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  Dir.glob(File.join("models/*.rb")) { |f| require "./#{f}" }
end

namespace :db do
  desc "Create DB"
  task :create, :env do |cmd, args|
    env = args[:env] || "development"
    user = DB_CONFIG[env]['username']
    password = DB_CONFIG[env]['password']
    host = DB_CONFIG[env]['host']
    db = DB_CONFIG[env]['database']
    Rake::Task['environment'].invoke(env)
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
    Rake::Task['environment'].invoke(env)
    %x(dropdb #{db})
  end

  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    Sequel.extension :migration
    Sequel::Migrator.apply(Cellar::DB, 'db/migrations')
  end

  desc 'Seed data'
  task :seed, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    load('db/seed.rb') if File.exist?('db/seed.rb')
  end

  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    Sequel.extension :migration
    version = (row = Cellar::DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(Cellar::DB, 'db/migrations', version - 1)
  end

  desc "Drop all tables in database"
  task :drop, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    Cellar::DB.tables.each do |table|
      Cellar::DB.run("DROP TABLE #{table}")
    end
  end

  desc "Clean Slate"
  task :reset, [:env] => [:nuke, :create, :drop, :migrate, :seed]
end

