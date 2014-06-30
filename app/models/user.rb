
class User < ActiveRecord::Base

    before_save { self.email = email.downcase }

	#validates :name, presence: true
	#validates :email, presence: true
    #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    #validates :email,  presence: true,  format: { with: VALID_EMAIL_REGEX },  uniqueness: true


# Validates : presence, length 	
    validates :name,  presence: true, length: { maximum: 50 }	
	
# Validates : presence, format 
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,  presence: true,  format: { with: VALID_EMAIL_REGEX },  uniqueness: { case_sensitive: false }    


# validates 
    has_secure_password
    validates :password, length: { minimum: 6 }

end
