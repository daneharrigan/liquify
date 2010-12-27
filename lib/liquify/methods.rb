module Liquify
  module Methods
    def self.included(base)
      base.send(:include, Liquify::InstanceMethods)
      base.send(:extend, Liquify::ClassMethods)
    end
  end

  module ClassMethods
    protected
      def liquify_method(*args)
        liquify_args = instance_variable_get :@liquify_args
        liquify_args ||= {}

        args.each do |arg|
          key, value = arg, :self

          if Hash === arg
            arg.each { |k, v| liquify_args[k.to_s] = v }
          else
            liquify_args[key.to_s] = value
          end
        end
        instance_variable_set :@liquify_args, liquify_args
      end
  end

  module InstanceMethods
    unless method_defined? :to_liquid
      def to_liquid #:nodoc:
        liquify_args = self.class.instance_variable_get(:@liquify_args) || {}
        liquify_output = instance_variable_get(:@liquify_output) || {}

        if liquify_output.empty?
          liquify_args.each do |key, value|
            if value.respond_to?(:call)
              liquify_output[key] = value.arity.zero? ? value.call : value.call(self)
            else
              liquify_output[key] = self.send(key)
            end
          end
        end

        liquify_output
      end
    end
  end
end
