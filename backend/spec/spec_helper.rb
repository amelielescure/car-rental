$LOAD_PATH.unshift File.expand_path("../../app", __FILE__)
require 'main'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|
end