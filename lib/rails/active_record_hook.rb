ActiveSupport.on_load(:active_record) do
  extend Liquify::ClassMethods
  include Liquify::InstanceMethods
end
