require 'specmon/adapter/circle_ci'

module Specmon
  class ExampleFetcher
    def self.fetch(project)
      if project.adapter == 'circleci'
        return Specmon::Adapter::CircleCi.new(project)
      else
        raise "No adapter found for #{project.adapter}"
      end
    end
  end
end
