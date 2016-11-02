require 'mina/rails'
require 'mina/bundler'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'xdev-server'
set :deploy_to, '/home/tamnguyen/apps/rails_5_api'
set :repository, 'git@github.com:ntamvl/rails_5_api_tutorial.git'
set :branch, 'deploy'

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

set :user, 'tamnguyen'
set :port, '22'

# They will be linked in the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('config')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_dirs, fetch(:shared_dirs, []).push('config', 'tmp/sockets', 'tmp/pids')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'Gemfile.lock')

# This task is the environment that is loaded all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.1p112}

  # puts "\nStarting to setup app on #{fetch(:domain)}\n"
  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/tmp"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/tmp"]

  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/tmp/pids"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/tmp/pids"]

  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/tmp/sockets"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/tmp/sockets"]

  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/log"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/log"]

  # command %[mkdir -p "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config"]
  # command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/#{fetch(:shared_path)}/config"]

  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  # command  %[echo "-----> Fill in information below to populate 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run :local { say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/docs
