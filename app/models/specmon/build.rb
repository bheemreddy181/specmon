module Specmon
  class Build < ActiveRecord::Base
    has_many :failures, -> { where(success: false) }, class_name: 'Example'
    has_many :examples
    has_many :examples_runtime_gt_1, -> { where('run_time >= 1.0') }, class_name: 'Example'
    has_many :examples_runtime_gt_0_5_lt_1, -> { where('run_time >= 0.5').where('run_time < 1.0') }, class_name: 'Example'
    has_many :examples_runtime_lt_0_5, -> { where('run_time < 0.5') }, class_name: 'Example'

    def previous
      @previous ||= self.class.where(project_id: project_id).where('id < ?', id).last
    end

    def next
      @next ||= self.class.where(project_id: project_id).where('id > ?', id).first
    end

    def as_json_resolved
      json = {}
      json[:id] = id
      json[:build_num] = build_num
      json[:vcs_revision] = vcs_revision.first(7)
      json[:stopped_at] = stopped_at
      json[:build_time] = ApplicationController.helpers.seconds_to_duration(build_time)
      json
    end

    def as_json_owner_resolved
      json = {}
      json[:owner] = owner
      json[:count] = count
      json[:sum] = sum.round(2)
      json[:avg] = avg.round(2)
      json
    end
  end
end
