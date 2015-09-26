class History < Volt::Model
    
    own_by_user
    
    field :project_id
    
    # using component 'volt-upload', url of picture
    field :picture
    
    field :created_at, Time
    
    field :message, String
    
    
  permissions( :delete) do
    # Only the admins who created the post can delete the project
    deny unless (admin?)
  end
  
  permissions( :update) do
    # Only the admins who created the post can delete the project
    deny unless (owner? || admin?)
  end

end
