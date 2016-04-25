require 'rake'
require 'specmon/example_fetcher'

namespace :specmon do
  Specmon.projects(false).each do |_id, project|
    desc "Fetch recent builds for #{project.id} project"
    task "#{project.id}:recent_builds" => :environment do
      puts "[START] Fetch recent builds for #{project.name} using #{project.adapter} adapter"
      Specmon::ExampleFetcher.fetch(project).recent_builds
      puts "[DONE] Fetch recent builds for #{project.name} using #{project.adapter} adapter"
    end
  end
end
