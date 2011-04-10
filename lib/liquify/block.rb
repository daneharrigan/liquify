module Liquify
  # Creating a block with Liquify is as simple as creating a Ruby
  # class.
  #
  #   class FooBlock < Liquify::Block
  #     def bar(params)
  #      ...
  #     end
  #
  #     def baz
  #      ...
  #     end
  #   end 
  #
  #   Liquify.setup do |config|
  #     config.register_tag :foo_block, FooBlock
  #   end
  #
  #   {% foo_block as: 'f' %}
  #     {{ f.bar 'arg1', key: 'value' }}
  #     {{ f.baz }}
  #   {% endfoo_block %}
  #
  # If you need wrapper content override the invoke method
  # and call yield within it.
  #
  class Block < Liquid::Block
    def initialize(tag_name, markup, tokens) # :nodoc:
      @tokens = tokens.dup
      super(tag_name, markup, tokens)
    end

    def render(context) # :nodoc:
      params = Liquify::Parameter.new(@markup, context)
      options = params.dup.extract_options!
      drop_tokens = @tokens.grep /\{\{\s*#{options['as']}\..*\}\}/

      context[options['as']] = Liquify::Block::Drop.new(self, drop_tokens, context)

      args = []
      args << params if method(:invoke).arity == 1

      context.stack do
        invoke(*args) do
          render_all(@nodelist, context).join
        end
      end
    end

    class Drop < Liquid::Drop
      def initialize(obj, tokens, context) # :nodoc:
        @obj = obj
        @params = {}

        tokens.each do |t|
          match, key, value = t.match(/\{\{\s*f\.(\w+)(.*)\}\}/).to_a

          @params[key] ||= []
          @params[key] << Liquify::Parameter.new(value, context)
        end
      end

      def invoke_drop(key) # :nodoc:
        allowed_methods = @obj.public_methods(false) - [:invoke]
        return unless allowed_methods.include?(key.to_sym)

        @obj.method(key).arity == 1 ? @obj.send(key, @params[key].pop) : @obj.send(key)
      end

      alias :[] :invoke_drop
    end
  end
end
