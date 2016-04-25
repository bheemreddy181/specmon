module Specmon
  class ExamplesController < ApplicationController
    def show
      @example = Example.find(params[:id])
    end

    def chart
      @data = Example.where(digest: @example.digest)
      @data = @data.joins(:build)
      @data = @data.order('specmon_builds.stopped_at desc')
      @data = @data.limit(100)
      @data = @data.pluck('specmon_builds.stopped_at', 'specmon_examples.run_time')
      render json: @data
    end
  end
end
