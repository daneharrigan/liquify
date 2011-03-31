require 'spec_helper'

describe Liquify::Methods do
  context 'when a hash with a lambda value is passed' do
    before(:all) do
      @cux_1 = Cux.new('John', 'Smith', {'age' => 25, 'gender' => 'M'})
      @cux_2 = Cux.new('Jane', 'Doe', {'age' => 22, 'gender' => 'F'})

      content = <<-STR
        {% for item in items %}
        <p>{{ item.full_name }}</p>
        <p>{{ item.options.age }}</p>
        {% endfor %}
      STR

      Liquify.setup do |c|
        c.register_drop :items, lambda { [@cux_1, @cux_2] }
      end

      @output = Liquify.invoke(content)
    end

    it 'returns values scoped to the first item' do
      @output.should =~ /<p>#{@cux_1.first_name} #{@cux_1.last_name}<\/p>/
      @output.should =~ /<p>#{@cux_1.options['age']}<\/p>/
    end

    it 'returns values scoped to the second item' do
      @output.should =~ /<p>#{@cux_2.first_name} #{@cux_2.last_name}<\/p>/
      @output.should =~ /<p>#{@cux_2.options['age']}<\/p>/
    end
  end
end
