require "config/capistrano_database_yml"

default_run_options[:pty] = true
set :application, "Inventory"
set :domain, "inventory.cycomsoft.com"
set :deploy_via, :remote_cache
set :deploy_to, "/opt/rails-apps/inventory/"
set :repository,  "."

set :user, "deployer"
set :scm, :git
set :scm_passphrase, "deployer"
set :repository, "git@github.com:rahmat-budiharso/inventory_v2.git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :use_sudo, false
set :copy_startegy, "checkout"
set :copy_compression, :gzip

role :web, "inventory.cycomsoft.com"                          # Your HTTP server, Apache/etc
role :app, "inventory.cycomsoft.com"                          # This may be the same as your `Web` server
role :db,  "inventory.cycomsoft.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

#after "deploy:update_code", :touch_restart_txt

#desc "touch restart.txt file to restart passenger"
#task :touch_restart_txt, :role => :app do
#  run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#end

depend :local, :command, "git"
depend :remote, :gem, "rails", "2.3.8"
depend :remote, :gem, "will_paginate", "2.3.14"
depend :remote, :gem, "authlogic", "2.1.5"
depend :remote, :gem, "searchlogic", "2.4.19"
depend :remote, :gem, "subdomain-fu", "0.5.4"
depend :remote, :gem, "cancan", "1.1.1"
depend :remote, :gem, "slim_scrooge", "1.0.10"
depend :remote, :gem, "formtastic", "0.9.10"
depend :remote, :gem, "chronic", "0.2.3"
depend :remote, :gem, "prawn", "0.8.4"
depend :remote, :gem, "haml", "3.0.13"
depend :remote, :gem, "spreadsheet", "0.6.4.1"
depend :remote, :gem, "paperclip", "2.3.3"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
