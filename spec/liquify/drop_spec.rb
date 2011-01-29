require 'spec_helper'

describe Liquify::Methods do
  describe '.liquify_method' do
    before(:each) do
      Liquify.setup do |config|
        config.register_drop :bar, BarDrop
      end
    end

    it 'returns the value of a method on the drop instance' do
      template = '{{ bar.first_name }} {{ bar.last_name }}'
      Liquify.invoke(template).should == 'Foo Bar'
    end

    it 'returns the output of a labmda with an argument passed' do
      Liquify.invoke('{{ bar.full_name }}').should == 'Foo Bar'
    end

    it 'returns the output of a labmda without an argument passed' do
      Liquify.invoke('{{ bar.age }}').should == '25'
    end
  end
end
