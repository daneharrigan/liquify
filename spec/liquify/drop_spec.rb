require 'spec_helper'

describe Liquify::Drop do
  describe '.liquify_method' do
    before(:each) do
      Liquify.setup do |config|
        config.register_drop :bar, BarDrop
      end
    end

    it 'returns the value of a method on the drop instance' do
      template = '{{ bar.first_name }} {{ bar.last_name }}'
      Liquify.render(template).should == 'Foo Bar'
    end

    it 'returns the output of the proc stored' do
      Liquify.render('{{ bar.full_name }}').should == 'Foo Bar'
    end
  end
end
