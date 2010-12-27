Liquify.setup do |config|
  # A tag is a class that inherits from Liquify::Tag or Liquid::Tag
  # config.register_tag :tag_name, TagClass

  # A drop is a class that inherits from Liquify::Drop or Liquid::Drop
  # config.register_drop :drop_name, DropClass

  # A filter is a method within a module. Multiple filters can be registered
  # at once within a single module.
  # config.register_filters FiltersModule
end
