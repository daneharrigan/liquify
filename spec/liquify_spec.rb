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

  describe '.invoke' do
    context 'when a drop is registered as a class' do
      before(:each) do
        foo_drop = mock(FooDrop, :to_liquid => {'first_name' => 'Foo'})
        FooDrop.should_receive(:new).and_return(foo_drop)
        @template = '{{ foo.first_name }}'

        Liquify.setup do |config|
          config.register_drop :foo, FooDrop
        end
      end

      it 'makes a new instance of the FooDrop' do
        Liquify.invoke(@template)
      end

      it 'renders "Foo" as the first name in the template' do
        Liquify.invoke(@template).should == 'Foo'
      end
    end

    context 'when additional context information needs to be added' do
      it 'renders as if it were registered in Liquify' do
        output = Liquify.invoke('{{ qux }}', :qux => 'cux qux')
        output.should == 'cux qux'
      end
    end
  end
end
