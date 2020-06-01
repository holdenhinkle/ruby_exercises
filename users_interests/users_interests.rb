require "pry"
require "tilt/erubis"
require "sinatra"
require "sinatra/reloader" if development?
require "yaml"

before do
  @users = @data = YAML::load(File.open("data/users.yaml"))
end

helpers do
  def format_name(name)
    name.to_s.capitalize
  end

  def other_users(user)
    @users.keys.reject { |name| name == user.to_sym }
  end

  def total_users
    @users.keys.size
  end

  def total_interests
    counter = 0
    @users.each { |user| counter += user[1][:interests].size }
    counter
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/users/:user" do
  @name = params["user"]
  redirect "/" unless @users.keys.include?(@name.to_sym)
  @user = @users[@name.to_sym]
  erb :user
end
