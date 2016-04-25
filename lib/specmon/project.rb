module Specmon
  class Project
    attr_reader :id, :settings, :connection_model

    def initialize(id, settings, connection = true)
      @id = id
      @settings = settings
      establish_connection(settings['url']) if connection && settings['url']
    end

    def builds
      Build.where(project_id: id)
    end

    def username
      settings['username'] || nil
    end

    def token
      settings['token'] || nil
    end

    def name
      settings['name'] || nil
    end

    def branch
      settings['branch'] || 'master'
    end

    def show_owners?
      settings['show_owners'] || false
    end

    def adapter
      settings['adapter'] || 'circleci'
    end
  end
end
