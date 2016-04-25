module Specmon
  module Adapter
    class Base
      def initialize(project)
        @project = project
      end

      def recent_builds
        raise 'Needs to be implemented'
      end
    end
  end
end
