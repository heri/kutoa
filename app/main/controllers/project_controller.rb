module Main
  class ProjectController < Volt::ModelController
    before_action only: [:new, :edit, :save] do
      require_login('Login')
    end
    
    # new project
    def new
      self.model = store.projects.buffer
    end
    
    # Edits an existing project
    def edit
      self.model = store.projects.where(id: params.id).first.then(&:buffer)
    end
    
    # Save a project
    def save
      model._created_at = Time.now
      model.save! do
        redirect_to '/projects/{{ model.id}}'
      end.fail do |errors|
        flash._errors << errors.to_s
      end
    end
    
    # find all projects which have been approved by Kutoa
    def index
      store.projects.where(approved_at: {$exists: true})
    end
    
    # show project queried by user
    def show
      store.projects.where(id: params.id).first
    end
    
  end
end