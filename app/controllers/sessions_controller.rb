
# Controller: for sessions 


class SessionsController < ApplicationController


# Upon signup
  def new
  end



# Upon successful signin  
  def create

    # Using the params hash 
    # We find the user profile 
    user = User.find_by(email: params[:session][:email].downcase)

    # If the password is correct 
    if user && user.authenticate(params[:session][:password])

      # Sign in the user and redirect to the user's show page
      sign_in user
      redirect_to user
      
    else

      # Create an error message and re-render the signin form  
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
      
    end

  end


# Upon signout
  def destroy
    sign_out
    redirect_to root_url
  end


end


