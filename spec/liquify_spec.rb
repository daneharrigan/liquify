require 'spec_helper'

describe Liquify do
  describe '.register_tag' do
    it 'adds a tag to liquify' do
      Liquify.setup do |config|
        config.register_tag :foo, FooTag
      end

      Liquify.class_variable_get(:@@tags).include?(:foo).should == true
    end
  end

  describe '.register_filters' do
    it 'adds a set of filters to liquify' do
      Liquify.setup do |config|
        config.register_filters FooFilters
      end

      Liquify.class_variable_get(:@@filters).include?(FooFilters).should == true
    end
  end

  describe '.register_drop' do
    it 'adds a drop  to liquify' do
      Liquify.setup do |config|
        config.register_drop :foo, FooDrop
      end

      Liquify.class_variable_get(:@@drops).include?(:foo).should == true
    end
  end

  describe '.render' do

  end
end
