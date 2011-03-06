require 'spec_helper'

describe 'active_record_hook' do
  describe '.liquify_method' do
    it 'responds to liquify_method' do
      Foo.respond_to?(:liquify_method).should == true
    end
  end
end
