

class User < ActiveRecord::Base

    before_save { self.email = email.downcase }


# Name validation : for presence and length 	
    validates :name,  presence: true, length: { maximum: 50 }		


# Email validation : for presence and format 
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,  presence: true,  format: { with: VALID_EMAIL_REGEX },  uniqueness: { case_sensitive: false }    


# Password validation : for many things and min. length 
    has_secure_password
    validates :password, length: { minimum: 6 }

end
