module Specmon
  class BuildsController < ApplicationController
    def index
      @builds = Build.where(project_id: @project.id).order(created_at: :desc).page(params[:page]).per(params[:per])
    end

    def show
      @build = Build.find_by_id(params[:id])
      if @build
        examples_for_build
        owners_for_build
        builds_over_the_time
      else
        flash[:warning] = "No builds found for #{@project.id}"
      end
    end

    def last
      @build = Build.where(project_id: @project.id).last
      if @build
        examples_for_build
        owners_for_build
        builds_over_the_time
      else
        flash[:warning] = "No builds found for #{@project.id}"
      end
      render :show
    end

    protected

    def builds_over_the_time
      @builds_over_the_time = Build
      @builds_over_the_time = @builds_over_the_time.order(created_at: :desc)
      @builds_over_the_time = @builds_over_the_time.where(project_id: @project.id)
      @builds_over_the_time = @builds_over_the_time.where('created_at > ?', 1.month.ago)
      @builds_over_the_time = @builds_over_the_time.map { |v| [v.created_at, v.build_time] }
    end

    def examples_for_build
      @examples = @build.examples
      @examples = @examples.where(owner: params[:owner]) if params[:owner].present?
      @examples = @examples.order(run_time: :desc)
      @examples = @examples.page(params[:page]).per(params[:per])
    end

    def owners_for_build
      @owners = @build.examples.uniq.map(&:owner).uniq.compact.reject(&:empty?).map { |v| Owner.new(v) }
    end
  end
end
