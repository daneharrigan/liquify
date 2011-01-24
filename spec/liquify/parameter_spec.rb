require 'spec_helper'

describe Liquify::Parameter do
  it 'parses a string into an array' do
    parameter = Liquify::Parameter.new('"a", "b", "c"')
    parameter.should == %W(a b c)
  end

  it 'parses a string into an array with a hash' do
    parameter = Liquify::Parameter.new('"a", "b", foo: "bar", baz: "cux"')
    parameter.should == ['a', 'b', {'foo' => 'bar', 'baz' => 'cux'}]
  end
end
