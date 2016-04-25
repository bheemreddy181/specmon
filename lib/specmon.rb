require 'yaml'
require 'chartkick'
require 'specmon/version'
require 'specmon/project'
require 'specmon/engine'

module Specmon
  class << self
    attr_reader :time_zone
  end

  def self.time_zone=(time_zone)
    @time_zone = time_zone.is_a?(ActiveSupport::TimeZone) ? time_zone : ActiveSupport::TimeZone[time_zone.to_s]
  end

  def self.settings
    @settings ||= begin
      path = root.join('config', 'specmon.yml').to_s
      if File.exist?(path)
        YAML.load(ERB.new(File.read(path)).result)
      else
        {}
      end
    end
  end

  def self.projects(connection = true)
    @projects ||= begin
      ds = Hash[
        settings['projects'].map do |id, s|
          [id, Specmon::Project.new(id, s, connection)]
        end
      ]
      ds.default = ds.values.first
      ds
    end
  end

  # Internal: `Rails.root` is nil in Rails 4.1 before the application is
  # initialized, so this falls back to the `RAILS_ROOT` environment variable,
  # or the current workding directory.
  def self.root
    Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
  end
end

require 'specmon/tasks'
