desc "Write a message to a file"
task :write_message do
  on roles(:greeter) do
    execute "echo '#{fetch :message}' >> ~/message.txt"
  end
end
