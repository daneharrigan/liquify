module Liquify
  class Block < Liquid::Block
    def initialize(tag_name, markup, tokens)
      @tokens = tokens.dup
      super(tag_name, markup, tokens)
    end

    def render(context)
      params = Liquify::Parameter.new(@markup)
      options = params.extract_options!
      drop_tokens = @tokens.grep /\{\{\s*#{options['as']}\..*\}\}/

      context[options['as']] = Liquify::Block::Drop.new(self, drop_tokens)

      context.stack do
        invoke do
          render_all(@nodelist, context).join
        end
      end
    end

    class Drop < Liquid::Drop
      def initialize(obj, tokens)
        @obj = obj
        @params = {}

        tokens.each do |t|
          match, key, value = t.match(/\{\{\s*f\.(\w+)(.*)\}\}/).to_a

          @params[key] ||= []
          @params[key] << Liquify::Parameter.new(value)
        end
      end

      def invoke_drop(key)
        allowed_methods = @obj.public_methods(false) - [:invoke]
        return unless allowed_methods.include?(key.to_sym)

        @obj.method(key).arity == 1 ? @obj.send(key, @params[key].pop) : @obj.send(key)
      end

      alias :[] :invoke_drop

      private
    end
  end
end
