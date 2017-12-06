namespace :user do
  desc 'Get auth token'
  task :auth_token, [:user_id] => [:environment] do |t, args|
    puts User.find(args[:user_id]).auth_token.token
  end
end
