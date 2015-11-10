class Like < Volt::Model
  own_by_user

  field :created_at, Time

  belongs_to :project
  belongs_to :user

  permissions(:update, :delete) do
    # Only the person who created the post can delete or update it
    deny unless (owner? || admin?)
  end

  def admin?
    Volt.current_user_id == ADMIN_ID
  end

end
