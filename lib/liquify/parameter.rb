module Liquify
  class Parameter < Array
    def initialize(markup, context={})
      markup = markup.split(',')
      @markup = markup
      args = []
      options = {}

      markup.each do |arg|
        key, value = arg.split(':')
        key = key.strip

        if value
          options[key] = find_from_context_or_value(value, context)
        else
          args << find_from_context_or_value(key, context)
        end
      end
      args << options unless options.empty?

      super(args)
    end

    unless self.instance_methods.include? :extract_options!
      def extract_options!
        last.is_a?(Hash) ? pop : {}
      end
    end

    private
      def strip_quotes(value)
        value.strip.gsub(/^('|")|('|")$/,'')
      end

      def find_from_context_or_value(value, context)
        value =~ /("|')/ ? strip_quotes(value.strip) : context[value.strip]
      end
  end
end
