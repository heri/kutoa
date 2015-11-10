# By default Volt generates this User model which inherits from Volt::User,
# you can rename this if you want.
class User < Volt::User
  # login_field is set to :email by default and can be changed to :username
  # in config/app.rb
  field login_field
  field :name
  field :bio, String
  field :is_refugee, Numeric
  field :is_host, Numeric
  field :phone_number, String
  field :is_admin, Numeric

  # url of picture
  field :picture

  has_many :likes
  has_many :cards
  has_many :comments

  validate login_field, unique: true, length: 8
  validate :email, email: true

  def admin?
    Volt.current_user_id == ADMIN_ID
  end

end
