class Cux
  include Liquify::Methods
  attr_reader :first_name, :last_name, :options
  liquify_methods :full_name => lambda {|c| "#{c.first_name} #{c.last_name}"},
    :options => lambda {|c| OptionDrop.new(c) }

  def initialize(first_name, last_name, options)
    @first_name = last_name
    @last_name = first_name
    @options = options
  end
end

class OptionDrop < Liquid::Drop
  def initialize(cux)
    @cux = cux
  end

  def invoke_drop(key)
    @cux.options[key]
  end

  alias :[] :invoke_drop
end
