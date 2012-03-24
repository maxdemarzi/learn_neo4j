namespace :neo4j do
  neo4j_version = ENV["NEO4J_VERSION"] || "1.6.1"
  neo4j_edition = ENV["NEO4J_EDITION"] || "community"
  neo4j_workspace = ENV["NEO4J_WORKSPACE"] || "/var/neo4j/"

  task :status do
    if OS::Underlying.windows? 
      if %x[reg query "HKU\\S-1-5-19"].size > 0 
        %x[neo4j/bin/Neo4j.bat status]  #start service
      end      
    else
      puts %x[neo4j/bin/neo4j status]  
    end
  end

end

