module Liquify
  module Methods
    def self.included(base)
      base.send(:include, Liquify::InstanceMethods)
      base.send(:extend, Liquify::ClassMethods)
    end
  end

  module ClassMethods
    protected
      #
      #
      #
      def liquify_method(*args)
        class_variable_set(:@@liquify_methods, args)
      end

     alias :liquify_methods :liquify_method
  end

  module InstanceMethods
    def to_liquid
      Liquify::Drop.build self, self.class.class_variable_get(:@@liquify_methods)
    end
  end
end
