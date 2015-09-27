

module Main
  class ProjectController < Volt::ModelController
    before_action only: [:new, :edit, :save, :add_like, :pledge] do
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
      unless model.created_at
        model._created_at = Time.now
      end
      model.save! do
        redirect_to ('/projects/' + model.id)
      end.fail do |errors|
        flash._errors << errors.to_s
      end
    end

    def icon_category(category)
      case category
      when "Housing"
        return "home"
      when "Education"
        return "university"
      when "Employment"
        return "wrench"
      end
    end

    def searched_projects
      (params._page = nil) if page._query

      query = { '$regex' => page._query || '', '$options' => 'i' }

      search_query = {'$or' => [{description: query},{name: query}]}

      # projects with approved date
      # approved = {'$and' => [search_query, {approved_at: { $exists: true}}]}

      store.projects.where(search_query)
    end

    def approved_projects
      searched_projects.all.skip(current_page * per_page).limit(per_page)
    end

    def index
    end

    # show project queried by user
    def show
      self.model = store.projects.where(id: params.id).first
    end

    def current_page
      (params._page || 0).to_i
    end

    def per_page
      CONST_PER_PAGE
    end

    def like_style(project)
      if Volt.current_user_id
        Volt.current_user.likes.where(project_id: project.id).first.then do |item|
          item ? "highlight" : ""
        end
      end
    end

    # current user likes
    def add_like(project)
      if Volt.current_user_id
        Volt.current_user.likes.where(project_id: project.id).first.then do |item|
          if item
            item.delete
            update_ranking(project, -1)
            flash._notices << "Removed from favorites"
          else
            like = Like.new(project: project, created_at: Time.now)
            store.likes << like
            update_ranking(project, 1)
            flash._notices << "Saved to favorites ♥"
          end
        end
      else
        flash._notices << "Login to add to favorites ♥"
      end
    end

    def update_ranking(project, bump)
      store.likes.where(project_id: project.id).all.then do |all_likes|
        project._ranking = all_likes.size
        project.save!
      end
    end

  end
end
