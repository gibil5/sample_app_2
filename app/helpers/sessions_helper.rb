

# Helper: for Session persistence 
# Uses: Rails cookies utilities 
module SessionsHelper


  def sign_in(user)

  	# Create a new token
    remember_token = User.new_remember_token

    # Place the token in the browser cookies
    cookies.permanent[:remember_token] = remember_token

    # Save the hashed token to the database
    user.update_attribute(:remember_token, User.digest(remember_token))

    # Set the current user equal to the given user 
    self.current_user = user

  end


  # To see is the user is signed in 
  def signed_in?
    !current_user.nil?
  end



  # Ruby trick: User defined assignement 
  def current_user=(user)
    @current_user = user
  end
  

  def current_user
    remember_token = User.digest(cookies[:remember_token])

    # Ruby trick: Works only if @current_user is undefined 
    @current_user ||= User.find_by(remember_token: remember_token)
  end



# Sign out 
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end



