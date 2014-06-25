

class User < ActiveRecord::Base

  #validates :name, presence: true
  validates :name,  presence: true, length: { maximum: 50 } 
   
  #validates :email, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  #                 uniqueness: true

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

end
