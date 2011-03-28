class BazDrop < Liquify::Drop
  attr_reader :name
  liquify_method :name => lambda { |b| BazStorage.new(b).name }

  def initialize(name)
    @name = name
  end
end

class BazStorage
  attr_reader :name

  def initialize(obj)
    @name = obj.name
  end
end
