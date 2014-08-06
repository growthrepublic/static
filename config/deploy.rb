require 'mina/bundler'
require 'mina/git'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'oktawave'
set :deploy_to, '/home/app/applications/static'
set :repository, 'git@github.com:growthrepublic/static.git'
set :branch, 'master'
set :term_mode, :system

set :shared_paths, []

# Optional settings:
set :user, 'app'    # Username in the server to SSH to.

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'

    to :launch do
    end
  end
end
