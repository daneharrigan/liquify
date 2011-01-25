module Liquify
  class Tag < Liquid::Tag
    def render(context)
      return unless respond_to? :invoke

      if method(:invoke).arity == 0
        invoke
      else
        params = Liquify::Parameters.new(@markup)
        invoke(params)
      end
    end
  end
end
