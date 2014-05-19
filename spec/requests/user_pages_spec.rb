require 'spec_helper'

describe "UserPages" do

  subject {page}

  describe "user sign up" do

    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }

  end

  describe "user profile" do
  	let (:user ) { FactoryGirl.create(:user) }
    before { visit user_path (user) }

    it { should have_content( user.name ) }
    it { should have_title( user.name ) }
  end

  describe "signup" do
  	  before { visit signup_path}

	  describe "with invalid information" do
	  	expect { click_button "Create my account"}.not_to change(User, :count)
	  end	

	  describe "with valid information" do
	  	before do
	  		fill_in "Name", with: "Example user"
	  		fill_in "Email", with: "user@example.com"
	  		fill_in "Password", with: "test"
	  		fill_in "Confirmation", with: "test"	
	  	end	
  		it "should create a user" do
        	expect { click_button submit }.to change(User, :count).by(1)
      	end
	  end 	
  end	  

end
