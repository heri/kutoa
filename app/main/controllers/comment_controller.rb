
module Main
  class CommentController < Volt::ModelController
    before_action do
      require_login('Login')
    end

    # Prepares a comment form by current user
    def new_comment
       self.model = attrs.project._comments.buffer
    end

    # Saves a comment by current user
    def save_project_comment
      model._created_at = Time.now
      model.save!.then do
        flash._notices << "Update added"
        new_comment
      end.fail do |err|
        flash._notices << err.to_s
      end
    end

    def current_page
      1
    end


  end
end
