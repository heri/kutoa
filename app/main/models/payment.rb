class Payment < Volt::Model
    
    own_by_user
    
    field :project_id
    field :created_at, Time
    
    # amount by user
    field :amount, Numeric
    
    field :token

end
