require 'spec_helper'

describe FooBlock do
  before(:each) do
    Liquify.setup do |c|
      c.register_tag :foo_block, FooBlock
      c.register_drop :item, lambda { 'Item Text' }
    end

    @content = <<-STR
      {% foo_block item, as: 'f' %}
        <p>{{ f.name 'foo' }}</p>
        <p>{{ f.name }}</p> <!-- intentionally blank -->
        <p>{{ f.name 'bar' }}</p>
        <p>{{ f.email }}</p>
        <p>{{ f.foo with: 'foo' }}</p>
      {% endfoo_block %}
    STR
    @output = Liquify.invoke(@content)
  end

  it 'has wrapper html' do
    @output.should =~ /<div id="block-wrapper" data-value="Item Text">.*<\/div>/m
  end

  it 'has an email field and does not take arguments' do
    @output.should =~ /<p>foo\.bar@baz\.com<\/p>/m
  end

  it 'has a name field of "foo"' do
    @output.should =~ /<p>foo<\/p>/
  end

  it 'has a second name field of "bar"' do
    @output.should =~ /<p>bar<\/p>/
  end

  it 'has a span with the word "foo"' do
    @output.should =~ /<p><span>foo<\/span><\/p>/
  end
end
