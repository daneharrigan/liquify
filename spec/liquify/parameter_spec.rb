require 'spec_helper'

describe Liquify::Parameter do
  it 'parses a string into an array' do
    parameters = Liquify::Parameter.new('"a", "b", "c"')
    parameters.should == %W(a b c)
  end

  it 'parses a string into an array with a hash' do
    parameters = Liquify::Parameter.new('"a", "b", foo: "bar", baz: "cux"')
    parameters.should == ['a', 'b', {'foo' => 'bar', 'baz' => 'cux'}]
  end

  context 'when a hash is passed in referencing a context value' do
    it 'assigns the context value to the hash entry' do
      parameters = Liquify::Parameter.new('"a", foo: bar', { 'bar' => {:cux => 'qux'} })
      parameters.should == ['a', {'foo' => {:cux => 'qux'} }]
    end
  end

  describe '#extract_options!' do
    context 'when a hash is available' do
      before(:each) do
        @parameters = Liquify::Parameter.new('"a", "b", foo: "bar", baz: "cux"')
        @options = @parameters.extract_options!
      end

      it 'returns the hash' do
        @options.should == {'foo' => 'bar', 'baz' => 'cux'}
      end

      it 'pulls the hash out of the parameters array' do
        @parameters.should == %W(a b)
      end
    end

    context 'when there is no hash' do
      before(:each) do
        @parameters = Liquify::Parameter.new('"a", "b", "c"')
        @options = @parameters.extract_options!
      end

      it 'returns an empty hash' do
        @options.should == {}
      end

      it 'should leave the parameters array untouched' do
        @parameters.should == %W(a b c)
      end
    end
  end
end
