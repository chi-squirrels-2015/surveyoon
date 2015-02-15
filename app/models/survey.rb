class Survey < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :questions
  has_many :answers, through: :questions
  has_many :responses

  def generate_code
    code = SecureRandom.urlsafe_base64
    self.update(random_code: code)
  end
end
