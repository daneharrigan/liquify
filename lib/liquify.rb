require 'liquid'
require 'liquify/methods'
require 'liquify/drop'

if defined?(Rails) && Rails.version >= '3'
  require File.expand_path(File.dirname(__FILE__) + '/rails/active_record_hook.rb')
end

module Liquify
  @@tags = {}
  @@filters = []
  @@drops = {}

  class << self
    def setup
      yield self
    end

    def register_tag(name, klass)
      @@tags[name] = klass
    end

    def register_filters(mod)
      @@filters << mod
    end

    def register_drop(name, klass)
      @@drops[name] = klass
    end

    def render(template)
      args = {}
      @@drops.each { |name, klass| args[name.to_s] = klass.respond_to?(:call) ? klass.call : klass.new }
      Liquid::Template.parse(template).render(args)
    end
  end
end
