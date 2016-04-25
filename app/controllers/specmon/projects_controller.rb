module Specmon
  class ProjectsController < ApplicationController
    def show
      if @project
        redirect_to controller: :examples, action: :index, project_id: @project.id
      else
        flash[:error] = 'Project not found'
      end
    end
  end
end
