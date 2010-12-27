module Liquify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Copy Liquify installation files'
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializers
        copy_file 'liquify.rb', 'config/initializers/liquify.rb'
      end
    end
  end
end
