module Liquify
  class Tag < Liquid::Tag
    def render(context)
      return unless respond_to? :invoke
      @context = context

      if method(:invoke).arity == 0
        invoke
      else
        params = Liquify::Parameter.new(@markup, context)
        invoke(params)
      end
    end

    private
      def context
        @context
      end
  end
end
