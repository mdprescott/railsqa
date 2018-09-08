namespace :deploy do
  desc "Runs rails db:setup"
  task :create_db do
    on roles(:db) do
      within release_path do
        execute :rails, "db:setup"
      end
    end
  end
end
