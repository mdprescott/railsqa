namespace :deploy do

  desc "Runs rails db:setup"
  task :create_db do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
         execute :rails, "db:setup"
        end
      end
    end
  end
end
