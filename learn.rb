require 'rubygems'
require 'neography'
require 'sinatra'
require 'uri'
require 'coffee-script'
require 'barista'
require 'sass/plugin/rack'

class Learn < Sinatra::Base

  get "/" do
    File.readlines("public/index.html")
  end

  get "/api/albums" do
    content_type "application/json"
    File.readlines("public/albums.json")
  end

  get "/api2/albums" do
    content_type :json
    [{
      "title"  => "Album A",
      "artist" => "Artist A",
      "tracks" => [{"title" => "Track A", "url" => "/music/Album A Track A.mp3" },{ "title" => "Track B", "url" => "/music/Album A Track B.mp3" }]
      },{
      "title"  => "Album B",
      "artist" => "Artist B",
      "tracks" => [{"title" => "Track A", "url" => "/music/Album B Track A.mp3" },{ "title" => "Track B", "url" => "/music/Album B Track B.mp3" }]
    }].to_json
  end
  
end