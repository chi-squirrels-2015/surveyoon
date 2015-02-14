class User < ActiveRecord::Base
  has_many :surveys, foreign_key: :creator_id
  has_many :questions, through: :surveys
  has_many :answers, through: :questions

  validates :username, uniqueness: true

  def password
    BCrypt::Password.new(self.password_hash)
  end

  def password=(input)
    self.password_hash = BCrypt::Password.create(input)
  end


  def self.authenticate(username, password_input)
    user = User.find_by(username: username)
    if user
      return user if user && user.password == password_input
    end
  end

end
