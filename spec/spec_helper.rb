require 'active_record'
require 'liquid'
require 'liquid/tag'
require 'liquify'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
