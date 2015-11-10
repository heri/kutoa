class Project < Volt::Model

  own_by_user

  # refugee for the project. It can be a family, in which case refugee would be an adult
  field :refugee_id
  field :host_id

  # in 140 characters, goal of the project for the refugee (Education, Employment, Housing)
  field :objective, String

  # more detailed description of the goal
  field :description, String

  # date when first payment would be required
  field :start_date, Time

  field :months

  field :picture, String

  field :total, Numeric

  field :ranking, Numeric

  # empty otherwise if there is a date, means the project has been approved by admin
  field :approved_at, Time

  field :created_at, Time

  # housing, education or employment
  field :category, String

  has_many :likes
  # Project updates
  has_many :comments

  permissions( :delete) do
    # Only the admins who created the post can delete the project
    deny unless (admin?)
  end

  permissions( :update) do
    # Only the admins who created the post can delete the project
    deny unless (owner? || admin?)
  end

  def monthly_amount
    return ('$' + total.to_s + '/mo')
  end

  def total_duration
    return (months.to_s + ' months')
  end

end
