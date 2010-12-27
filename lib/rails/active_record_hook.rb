ActiveSupport.on_load(:active_record) do
  include Liquify::Methods
end
