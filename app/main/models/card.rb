class Card < Volt::Model
  own_by_user

  # field :created_at, Time
  #
  # field :addressLine1
  #
  # field :addressLine2
  #
  # field :addressCity
  #
  # field :addressState
  #
  # field :addressZip

  field :name
  # validate :name, presence: true
  # validate :name, length: 10


  field :number
  # validate :number, presence: true
  # validate :number, length: 16

  field :expMonth
  # validate :expMonth, presence: true
  # validate :expMonth, length: 2

  field :expYear
  # validate :expYear, presence: true
  # validate :expYear, length: 2

  field :cvc
  # validate :cvc, presence: true
  # validate :cvc, length: 3


  permissions(:update, :delete) do
    # Only the person who created the post can delete or update it
    deny unless (owner?)
  end

end
