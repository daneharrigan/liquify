class BarDrop
  include Liquify::Methods
  liquify_method :first_name, :last_name,
    :full_name => lambda { |drop| "#{drop.first_name} #{drop.last_name}" },
    :age => lambda { '25' }

  def first_name
    'Foo'
  end

  def last_name
    'Bar'
  end
end
