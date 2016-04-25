module Specmon
  module ApplicationHelper
    def build_path_in_current_project_context(build, params = nil)
      project_build_path(@project.id, build, params)
    end

    def example_path_in_current_project_and_build_context(example, params = nil)
      project_build_example_path(@project.id, @build.id, example, params)
    end

    def example_chart_path_in_current_project_and_build_context(example, params = nil)
      project_build_example_chart_path(@project.id, @build.id, example, params)
    end

    def is_active(controller_name)
      params[:controller].include? controller_name ? 'active' : nil
    end

    def paginate(objects, options = {})
      options.reverse_merge!(theme: 'twitter-bootstrap-3')
      super(objects, options)
    end

    def icon_class_for(flash_type)
      case flash_type
      when 'success'
        'glyphicon-ok-sign'
      when 'error'
        "'glyphicon-warning-sign"
      when 'danger'
        "'glyphicon-warning-sign"
      when 'notice'
        'glyphicon-info-sign'
      when 'info'
        'glyphicon-info-sign'
      when 'warning'
        'glyphicon-warning-sign'
      end
    end

    def alert_class_for(flash_type)
      case flash_type
      when 'success'
        'success'
      when 'error'
        'danger'
      when 'notice'
        'info'
      when 'warning'
        'warning'
      else
        'default'
      end
    end

    def alert_class_for_runtime(runtime)
      if runtime >= 1
        'danger'
      elsif runtime < 1 && runtime >= 0.5
        'warning'
      elsif runtime < 0.5 && runtime >= 0
        'success'
      end
    end

    def seconds_to_duration(seconds)
      Time.at(seconds).utc.strftime('%H:%M:%S')
    end

    def circleci_url(build_num)
      "https://circleci.com/gh/#{@project.username}/#{@project.id}/#{build_num}"
    end

    def github_url(vcs_revision)
      "https://github.com/#{@project.username}/#{@project.id}/commit/#{vcs_revision}"
    end
  end
end
