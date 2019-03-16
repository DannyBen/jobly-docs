require "sinatra/base"

class MyServer < Sinatra::Base
  get '/' do
    "Hello from MyServer!"
  end
end