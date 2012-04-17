require 'neography/tasks'
require './learn.rb'

namespace :neo4j do
  task :create do
    create_graph
  end
end
begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
