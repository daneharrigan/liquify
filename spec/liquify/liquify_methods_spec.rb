require 'spec_helper'

describe Liquify::Methods do
  before(:each) do
    @baz_1 = Baz.new('baz -1')
    @baz_2 = Baz.new('baz -2')
  end

  context 'when exposing a value as a lambda' do
    it 'is scoped to that object instance' do
      @baz_1.to_liquid['name']['value'].should == @baz_1.name
      @baz_2.to_liquid['name']['value'].should == @baz_2.name
    end
  end

  context 'when the template is rendered' do
    it 'contains values for both baz_1 and baz_2' do
      Liquify.setup do |c|
        c.register_drop :baz, lambda { [@baz_1, @baz_2] }
      end

      content = <<-STR
        {% for b in baz %}
        <p>{{ b.name.value }}</p>
        {% endfor %}
      STR

      output = Liquify.invoke(content)

      output.should =~ /<p>#{@baz_1.name}<\/p>/
      output.should =~ /<p>#{@baz_2.name}<\/p>/
    end
  end
end
