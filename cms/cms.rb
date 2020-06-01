require 'pry'
require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
require "redcarpet"
require "yaml"
require "bcrypt"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

helpers do
  def valid_file_name?(name)
    !no_file_name?(name) && !no_file_extension?(name)
  end

  def no_file_name?(name)
    name.empty? || name.gsub(/\.[a-z0-9]+/i, '').empty?
  end

  def no_file_extension?(name)
    name.gsub(/^[a-z0-9]+/i, '').empty?
  end

  def signed_in?
    session[:username]
  end

  def not_signed_in?
    !session[:username]
  end

  def not_signed_in_alert
    session[:message] = "You must be signed in to do that."
  end
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

def convert_html_to_md(content)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(content)
end

def load_file_content(path)
  content = File.read(path)
  case File.extname(path)
  when ".txt"
    headers["Content-Type"] = "text/plain"
    content
  when ".md"
    convert_html_to_md(content)
  end
end

def load_user_credentials
  credentials_path = if ENV["RACK_ENV"] == "test"
                       File.expand_path("../test/users.yml", __FILE__)
                     else
                       File.expand_path("../users.yml", __FILE__)
                     end
  YAML.load_file(credentials_path)
end

def valid_credentials?(username, password)
  credentials = load_user_credentials

  if credentials.key?(username)
    bcrypt_password = BCrypt::Password.new(credentials[username])
    bcrypt_password == password
  else
    false
  end
end

get "/" do
  pattern = File.join(data_path, "*")
  @files = Dir.glob(pattern).map do |path|
    File.basename(path)
  end
  erb :index
end

get '/new' do
  if not_signed_in?
    not_signed_in_alert
    redirect "/"
  end

  erb :new
end

post '/create' do
  filename = params[:filename].strip
  if valid_file_name?(filename)
    File.new(File.join(data_path, filename), "w")
    session[:message] = "#{filename} was created."
    redirect '/'
  elsif no_file_name?(filename) && no_file_extension?(filename)
    session[:message] = "A name and extension is required."
  elsif no_file_name?(filename)
    session[:message] = "A file name is also required."
  elsif no_file_extension?(filename)
    session[:message] = "An file extension is also required."
  end
  status 422
  erb :new
end

get '/:filename' do
  f = params[:filename]
  file_path = File.join(data_path, f)

  if File.file?(file_path)
    load_file_content(file_path)
  else
    session[:message] = "#{f} does not exist."
    redirect '/'
  end
end

get '/edit/:filename' do
  if not_signed_in?
    not_signed_in_alert
    redirect "/"
  end

  f = params[:filename]
  file_path = File.join(data_path, f)

  if File.file?(file_path)
    @content = File.read(file_path)
    erb :edit
  else
    session[:message] = "#{f} does not exist."
    redirect '/'
  end
end

post '/edit/:filename' do
  f = params[:filename]
  file_path = File.join(data_path, f)

  if File.file?(file_path)
    File.write(file_path, params["content"])
    session[:message] = "#{f} has been updated."
  else
    session[:message] = "#{f} does not exist."
  end
  redirect "/"
end

post '/delete/:filename' do
  if not_signed_in?
    not_signed_in_alert
    redirect "/"
  end

  File.delete(File.join(data_path, params[:filename]))
  session[:message] = "#{params[:filename]} was deleted."
  redirect "/"
end

get '/users/signin' do
  erb :signin
end

post '/users/signin' do
  username = params[:username]
  if valid_credentials?(username, params[:password])
    session[:username] = username
    session[:message] = "Welcome!"
    redirect '/'
  else
    session[:message] = "Invalid credentials"
    status 422
    erb :signin
  end
end

post "/users/signout" do
  session.delete(:username)
  session[:message] = "You have been signed out."
  redirect '/'
end
