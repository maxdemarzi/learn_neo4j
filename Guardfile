guard 'coffeescript', :output => 'public/javascripts' do
  watch(/^app\/coffeescripts\/(.*)\.coffee/)
end

guard 'coffeescript', :output => 'spec/javascripts' do
  watch(/^spec\/coffeescripts\/(.*)\.coffee/)
end

guard 'livereload' do
  watch(/^spec\/javascripts\/.+\.js$/)
  watch(/^public\/javascripts\/.+\.js$/)
end