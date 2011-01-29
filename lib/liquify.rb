require 'liquid'
require 'liquify/methods'
require 'liquify/parameter'
require 'liquify/drop'
require 'liquify/tag'

if defined?(Rails) && Rails.version >= '3'
  require File.expand_path(File.dirname(__FILE__) + '/rails/active_record_hook.rb')
end

module Liquify
  @@tags = {}
  @@filters = []
  @@drops = {}

  class << self
    # setup - This method allows you to register tags, drops and filters.
    # to Liquify in one place.
    #
    #   Liquify.setup do |config|
    #     ...
    #   end
    def setup
      yield self
    end

    # register_tag - This method is used to make tags available to your
    # Liquid templates. It accepts a symbol for the tag name and the tag class.
    #
    #   Liquify.setup do |config|
    #     config.register_tag :tag_name, NameTag
    #   end
    def register_tag(name, klass)
      @@tags[name] = klass
    end

    # register_filters - This method is used to make filters available to
    # your Liquid templates. It accepts a module of methods. Each method
    # becomes a Liquid filter.
    #
    #   Liquify.setup do |config|
    #     config.register_filters CustomFilters
    #   end
    def register_filters(mod)
      @@filters << mod
    end

    # register_drop - This method is used to make drops available to
    # your Liquid templates. It accepts a symbol for the drop name and
    # your drop class or a lambda if processing has to be done at time
    # time of rendering the Liquid template.
    #
    #   Liquify.setup do |config|
    #     config.register_drop :drop_name, NameDrop
    #     # with a lamda
    #     config.register_drop :special_name, lambda { Foo.first }
    #   end
    def register_drop(name, klass)
      @@drops[name] = klass
    end

    # invoke = This method handles to rendering of the Liquid template with
    # all of the registered drops, tags and filters. It accepts the Liquid
    # template as a string.
    #
    #  template = '{{ drop_name.method }}'
    #  Liquify.invoke(template) # => Rendered Liquid template
    def invoke(template)
      args = {}
      @@drops.each { |name, klass| args[name.to_s] = klass.respond_to?(:call) ? klass.call : klass.new }
      @@filters.each { |filter| Liquid::Template.register_filter(filter) }
      @@tags.each { |tag, klass| Liquid::Template.register_tag(tag, klass) }
      Liquid::Template.parse(template).render(args)
    end
  end
end
