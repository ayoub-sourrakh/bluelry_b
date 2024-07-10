# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

require 'capistrano-db-tasks'

set :application, "Bluelry"
set :repo_url, "git@github.com:ayoub-sourrakh/bluelry_b.git"
set :filter, :roles => %w{app}
set :use_sudo, true
set :deploy_to, '/home/ubuntu/bluelry_b'
set :branch, 'main'
set :rails_env, 'production'
set :assets_prefix, 'packs'
# In deploy.rb
# Add or adjust default_env to append .npm-packages to $PATH:
set :default_env, {
  PATH: '$HOME/.npm-packages/bin/:$PATH',
  NODE_ENVIRONMENT: 'production',
  'DATABASE_USERNAME' => ENV['DATABASE_USERNAME'],
  'DATABASE_PASSWORD' => ENV['DATABASE_PASSWORD'],
  'DATABASE_HOST' => ENV['DATABASE_HOST'],
  'DATABASE_NAME' => ENV['DATABASE_NAME']
}
####
set :linked_files, %w{config/database.yml config/credentials/production.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle .bundle public/system public/uploads public/packs node_modules }
set :keep_releases, 3
set :keep_assets, 3
set :db_local_clean, true
set :db_remote_clean, true
set :migration_role, 'app'
set :conditionally_migrate, false
task :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  
  after :finishing, 'deploy:cleanup'
  after 'deploy:cleanup', 'deploy:restart'
end
