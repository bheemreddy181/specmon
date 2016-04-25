module Specmon
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_filter :project
    before_filter :build
    before_filter :example

    protected

    def project
      @project = Specmon.projects.select { |p| p.to_s == params[:project_id].to_s }.first.last if params[:project_id].present?
      @project ||= Specmon.projects.select { |p| p.to_s == params[:id].to_s }.first.last if params[:id].present?
      @project ||= Specmon.projects.first.last
    end

    def build
      @build = Build.find(params[:build_id]) if params[:build_id].present?
    end

    def example
      @example = Example.find(params[:example_id]) if params[:example_id].present?
    end
  end
end
