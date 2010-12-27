class Foo < ActiveRecord::Base
  liquify_method :first_name, :last_name
  attr_accessor :first_name, :last_name

  def initialize(args)
    @first_name = args[:first_name]
    @last_name = args[:last_name]
  end
end
