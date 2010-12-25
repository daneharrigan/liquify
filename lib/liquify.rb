module Liquify
  @@tags = {}
  @@filters = []
  @@drops = {}

  class << self
    def setup
      yield self
    end

    def register_tag(name, klass)
      @@tags[name] = klass
    end

    def register_filters(mod)
      @@filters << mod
    end

    def register_drop(name, klass)
      @@drops[name] = klass
    end
  end
end
