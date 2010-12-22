set :application, "instagram"
set :repository,  "git://github.com/mitukiii/instagram-viewer.git"
set :scm, :git

set :deploy_to, "/var/www/html/mitukiii/#{application}"

role :web, "mitukiii.jp"
role :app, "mitukiii.jp"

namespace :deploy do
  # Restart the application servers.
  task :restart, :roles => :app do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
