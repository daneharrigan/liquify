class Baz
  include Liquify::Methods
  attr_reader :name
  liquify_method :name => lambda { |b| NameDrop.new(b) }

  def initialize(name)
    @name = name
  end
end

class NameDrop < Liquify::Drop
  def initialize(obj)
    @obj = obj
    @values = {'value' => @obj.name}
  end

  def [](key)
    @values[key]
  end
end

# liquify_method
# create drop
# create methods
