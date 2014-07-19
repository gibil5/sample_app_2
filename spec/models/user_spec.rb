
# Tests: for the User


require 'spec_helper'

describe User do


  # pending "add some examples to (or delete) #{__FILE__}"


# Creates an example user, for the test 
  before do     
    @user = User.new(name: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end



# Makes it the subject of the test
  subject { @user }



# Test for 

  # Existence
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }

  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }



# Sanity check. Verifying that the subject @user is valid 
  it { should be_valid }



#------------------------------------------------------------------------------
# Name and Email Tests 
#------------------------------------------------------------------------------

# Test for presence 
# Name 
  describe "when name is not present" do
  	# Creates an example user name 
    before { @user.name = " " }
    it { should_not be_valid }
  end
# Email 
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end


# Test for length
# Name 
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end


# Test for format 
# Invalid 
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
# Valid 
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end


# When mail already taken 
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      # Test case insensitivity 
      user_with_same_email.email = @user.email.upcase      
      user_with_same_email.save
    end

    it { should_not be_valid }
  end




#------------------------------------------------------------------------------
# Password Tests 
#------------------------------------------------------------------------------

  # Avoid user entering a blank password 
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                     password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end


  # Password and password confirmation are not equal
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end



  
  # User authentication 

  # Length validation. Should be at least six characters long 
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end



# The two cases of pwd match and mismatch 
  describe "return value of authenticate method" do

    # Saves the user to the db, so that it can be retrieved by the find_by method 
    # let method provide a way to create local variables inside tests 
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end




#-----------------
# Remember token
#-----------------

# Test the Remember token 
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end


end


