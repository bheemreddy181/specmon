require "open-uri"
require "faraday"
require "descriptive_statistics"
require "activerecord-import"
require "specmon/adapter/base"

module Specmon
  module Adapter
    class CircleCi < Adapter::Base

      def initialize(project)
        super(project)
        @base_url = "https://circleci.com/api/v1/project/#{@project.username}/#{@project.name}"
      end

      def build_uri(path, token: nil)
        uri = @base_url
        uri = uri + path
        uri = uri + "?circle-token=#{token}" if token
        uri
      end

      def create_examples_from_build(build_num:)
        examples = []
        artifacts = JSON.parse(Faraday.new.get(build_uri("/#{build_num}/artifacts", token: @project.token || nil)).body)
        artifacts.select { |artifact| artifact["path"].ends_with?("rspec.xml") }.each do |artifact|
          doc = Nokogiri::HTML(open("#{artifact["url"]}?circle-token=#{@project.token}"))
          doc.css("testcase").inject(examples) do |memo, testcase|
            file = testcase["file"].gsub(/^\.\//, "")
            memo << Specmon::Example.new({
              file: file,
              name: testcase["name"],
              run_time: testcase["time"],
              line_number: testcase["line_number"],
              owner: testcase["owner"],
              digest: Digest::MD5.hexdigest([file, testcase["name"]].join),
              success: testcase.css("failure").length == 0
            })
          end
        end

        build_details = JSON.parse(Faraday.new.get(build_uri("/#{build_num}", token: @project.token || nil)).body)
        run_times = examples.map(&:run_time)

        ActiveRecord::Base.transaction do
          build = Specmon::Build.create!({
            project_id: @project.id,
            vcs_revision: build_details["vcs_revision"],
            build_num: build_details["build_num"],
            started_at: build_details["start_time"],
            stopped_at: build_details["stop_time"],
            build_time: build_details["build_time_millis"] / 1000,
            queue_time: Time.parse(build_details["start_time"]).to_i - Time.parse(build_details["queued_at"]).to_i,
            run_time_sum: run_times.sum,
            run_time_max: run_times.max,
            run_time_median: run_times.median,
            run_time_mean: run_times.mean,
            examples_count: examples.length,
            status: build_details["status"]
          })

          build.examples.import(examples)
        end
      end

      def recent_builds
        request = Faraday.new.get(build_uri("/tree/#{@project.branch}", token: @project.token || nil))
        abort "[ERROR] Status: #{request.status} | Message: #{JSON.parse(request.body)['message']}" if request.status != 200
        recent_successful_builds = JSON.parse(request.body)
        recent_successful_builds.reverse.each do |build|
          unless Specmon::Build.where(vcs_revision: build["vcs_revision"]).exists?
            create_examples_from_build(build_num: build["build_num"])
          end
        end
      end

    end
  end
end
