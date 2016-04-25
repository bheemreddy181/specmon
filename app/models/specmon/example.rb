module Specmon
  class Example < ActiveRecord::Base
    belongs_to :build
    validates :file, :name, :run_time, presence: true

    def as_json_resolved
      json = {}
      json[:owner] = owner
      json[:name] = name.truncate(50)
      json[:file] = "#{file.truncate(200)}:#{line_number}"
      json[:run_time] = run_time.round(1)
      json
    end
  end
end
