$:.push File.expand_path("../lib", __FILE__)

require 'sinatra'
require 'kronix'

get '/build' do
  Kronix.build(Dir.pwd + "/test/dummy") ? "Build complete ok!" : "Build fail =/"
end
