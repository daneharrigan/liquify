require 'spec_helper'

describe Liquify::Methods do
  context 'when exposing a value as a lambda' do
    it 'is scoped to that object instance' do
      baz_1 = BazDrop.new('baz -1')
      baz_2 = BazDrop.new('baz -2')

      baz_1.to_liquid['name'].should == baz_1.name
      baz_2.to_liquid['name'].should == baz_2.name
    end
  end
end
