module Liquify
  class Drop < Liquid::Drop
    class << self
      def build(obj, values)
        obj.class.class_eval <<-STR
          class DynamicDrop < Liquify::Drop
            def initialize(obj, values)
              @object = obj
              @blocks = {}

              values.each do |value|
                if value.is_a? Hash
                  value.each { |key, val| @blocks[key] = val }
                end
              end
            end
          end
        STR

        obj.class::DynamicDrop.class_eval do
          values.each do |item|
            if item.is_a? Hash
              item.each do |key, value|
                define_method key do
                  block = @blocks[key]
                  block.arity.zero? ? block.call : block.call(@object)
                end
              end
            else
              define_method item do
                @object.send item
              end
            end
          end
        end

        obj.class::DynamicDrop.new(obj, values)
      end
    end
  end
end
=begin
      private
        def build_hash
          @values.each do |key, value|
           self.class.class_eval do
             define_method(key) { @values[key] } 
           end
          end
        end

        def build_default
          @values.each do |item|
            if item.is_a? Hash
              item.each do |key, value|
                self.class.class_eval do
                  define_method key do
                    value.arity.zero? ? value.call : value.call(@obj)
                  end
                end
              end
            else
              self.class.class_eval do
                define_method(item) { @obj.send(item) }
              end
            end
          end
        end
=end
=begin
    def build(obj, values, options={})
      case options[:as]
        when :hash
          build_hash
        else
          build_default
        end
      self
    end

    private
      def build_hash
        @values.each do |key, value|
         self.class.class_eval do
           define_method(key) { @values[key] } 
         end
        end
      end

      def build_default
        @values.each do |item|
          if item.is_a? Hash
            item.each do |key, value|
              self.class.class_eval do
                define_method key do
                  value.arity.zero? ? value.call : value.call(@obj)
                end
              end
            end
          else
            self.class.class_eval do
              define_method(item) { @obj.send(item) }
            end
          end
        end
      end
  end
=end
