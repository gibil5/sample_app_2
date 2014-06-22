
# Description of tests. For TDD (Test Driven Development).

require 'spec_helper'


describe "Static pages" do

  let(:base_title) { "Ruby on Rails" }


  subject { page }



  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }
    #it { should have_title("Ruby on Rails") }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end




  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    #it { should have_title("#{base_title} | Help") }
    it { should have_title(full_title('Help')) }
  end



  describe "About page" do
    before { visit about_path }

    it { should have_content('About Us') }
    #it { should have_title("#{base_title} | About Us") }
    it { should have_title(full_title('About Us')) }
  end



  describe "Contact" do

    before { visit contact_path }

    it { should have_content('Contact') }
    #it { should have_title("#{base_title} | Contact") }
    it { should have_title(full_title('Contact')) }
  end

end

