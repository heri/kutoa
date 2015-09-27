class History < Volt::Model

    own_by_user

    belongs_to :project

    # using component 'volt-upload', url of picture
    field :picture

    field :created_at, Time

    field :message, String

    validate :message, length: 1


  permissions( :delete) do
    # Only the admins who created the post can delete the project
    deny unless (admin?)
  end

  permissions( :update) do
    # Only the admins who created the post can delete the project
    deny unless (owner? || admin?)
  end

end
