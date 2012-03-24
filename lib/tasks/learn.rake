require 'rubygems'
require 'neography'
 
@neo = Neography::Rest.new

namespace :learn do
 
  task :add_topic, :topic do |t, args|
    puts "Adding topic #{args.topic}"
  end
 
  task :topics do
    puts "list topics"
  end
end

