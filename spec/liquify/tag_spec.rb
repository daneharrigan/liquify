require 'spec_helper'

describe Liquify::Tag do
  before(:each) do
    Liquify.setup do |config|
      config.register_tag :foo, FooTag
      config.register_drop :bar, BarDrop
    end
  end

  context 'when a single argument is passed in' do
    it 'returns the argument' do
      template = '{% foo "bar" %}'
      Liquify.invoke(template).should == 'bar'
    end
  end

  context 'when an argument and a hash is passed in' do
    it 'returns the argument and the hash value' do
      template = '{% foo "bar", bar: "baz" %}'
      Liquify.invoke(template).should == 'bar baz'
    end
  end

  context 'when an argument is not quoted' do
    it 'returns the context value that matches the name' do
      template = '{% foo "bar", user: bar %}'
      Liquify.invoke(template).should == 'bar Foo'
    end
  end
end
