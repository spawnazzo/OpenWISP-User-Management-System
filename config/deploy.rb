# =============================================================================
# GENERAL SETTINGS
# =============================================================================

set :stages, %w(test-puppet1)

set :application,  "owums"
set :deploy_to,  "/var/rails/#{application}"
set :rails_env, "production"

set :scm, :subversion
set :repository, "https://spider.caspur.it/svn/owums/trunk"

set :rvm_ruby_string, 'ree'

# =============================================================================
# CAP RECIPES
# =============================================================================

# Capistrano multistage
require 'capistrano/ext/multistage'

# Colorize capistrano output
require 'capistrano_colors'

# Note this happens after the general settings have been defined
require 'rubygems'

# Utility methods from cap_recipes
require 'cap_recipes/tasks/utilities'
extend Utilities

# RVM
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'

# RUBYGEMS
require 'cap_recipes/tasks/rubygems'
set :rubygem_paths, "/usr/local/bin/gem"

# BUNDLER
require 'bundler/capistrano'

# RAILS
require 'cap_recipes/tasks/rails/manage'
after "deploy:restart", "rails:repair_permissions" # fix the permissions to work properly

# PASSENGER
require 'cap_recipes/tasks/passenger'

# CUSTOM RECIPES
load 'lib/recipes/rails'
load 'lib/recipes/deploy'
