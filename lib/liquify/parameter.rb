module Liquify
  class Parameter < Array
    def initialize(markup)
      markup = markup.split(',')
      args = []
      options = {}

      markup.each do |arg|
        key, value = arg.split(':')
        key = strip_quotes(key)

        if value
          value = strip_quotes(value)
          options[key] = value
        else
          args << key
        end
      end
      args << options unless options.empty?

      super(args)
    end

    private
      def strip_quotes(value)
        value.strip.gsub(/^('|")|('|")$/,'')
      end
  end
end
