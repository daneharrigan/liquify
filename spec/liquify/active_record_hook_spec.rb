require 'spec_helper'

describe 'active_record_hook' do
  before(:each) do
    Foo.stub :establish_connection => true
  end

  describe '.liquify_method' do
    it 'responds to liquify_method' do
      Foo.respond_to?(:liquify_method).should == true
    end
  end

  describe '#to_liquid' do
    before(:each) do
      @foo = Foo.new(:first_name => 'Foo', :last_name => 'bar')
      @foo.stub :establish_connection => true
    end
    it 'responds to "to_liquid"' do
      @foo.respond_to?(:to_liquid).should == true
    end

    it 'returns "Foo"' do
      @foo.to_liquid['first_name'].should == 'Foo'
    end

    it 'returns "Bar"' do
      @foo.to_liquid['last_name'].should == 'Bar'
    end
  end
end
