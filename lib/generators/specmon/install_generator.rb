# taken from https://raw.githubusercontent.com/collectiveidea/audited/master/lib/generators/audited/install_generator.rb
require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'
require 'rails/generators/active_record'
require 'generators/specmon/migration'

module Specmon
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      extend Specmon::Generators::Migration

      source_root ::File.expand_path('../templates', __FILE__)

      def copy_migration
        migration_template 'install.rb', 'db/migrate/install_specmon.rb'
      end

      def copy_config
        template 'config.yml', 'config/specmon.yml'
      end
    end
  end
end
