

# User model 

class User < ActiveRecord::Base

    before_save { self.email = email.downcase }    
    before_create :create_remember_token


# Name validation : for presence and length 	
    validates :name,  presence: true, length: { maximum: 50 }		


# Email validation : for presence and format 
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,  presence: true,  format: { with: VALID_EMAIL_REGEX },  uniqueness: { case_sensitive: false }    


# Password validation : for many things and min. length 
    has_secure_password
    validates :password, length: { minimum: 6 }




# A before_create callback to create a remember token inmediately before 
# creating a new user in the database

  	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end


    # Callback method to create a remember_token 
    # No need to expose it to outside users 
  	private
    
      def create_remember_token
        self.remember_token = User.digest(User.new_remember_token)
      end

end

