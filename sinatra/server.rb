require 'bundler/setup'
require 'sinatra'
require 'json'

enable :sessions
# user = nil  # 1 - destroys user in session on restart

before do
  # session[:user] = nil unless user  # 1
  redirect to('/auth') unless request.path_info == '/auth' || session[:user]
end

get '/' do
  {
    memory: memory,
    disk: disk
    }.to_json
end

get '/memory/?:id?' do
  {memory: memory}.to_json
end

get '/disk/?:id?' do
  {disk: disk}.to_json
end

get '/help' do
  erb :index
end

get '/auth' do
  session[:user] ? (redirect to '/help') : (erb :auth)
end

post '/auth' do
  if params[:user] == 'admin' && params[:pass] == 'admin'
    session[:user] = params[:user]
    # user = 'admin'  # 1
    redirect to '/help'
  else
    redirect to '/auth'
  end
end

def disk
  info %x(df -h).split("\n")
end

def memory
  info %x(free -m).split("\n")
end

def info arg
  params[:id].nil? ? arg : arg[params[:id].to_i - 1]
end