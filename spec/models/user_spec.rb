require 'spec_helper'

describe User do
  before { @user = User.new(name: "Hakim", email:"h@haha.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }

  it { should be_valid }

  describe "when password and confirmation is blank" do
    before do
      @user.password = " "
      @user.password_confirmation = " "
    end
    it { should_not be_valid }
  end

  describe "when password confirmation does not match" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password is too long" do
    before do
      @user.password = "p" * 11
    end
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51}
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before {@user.email=" "}
    it { should_not be_valid}
  end

  describe "when email is invalid" do

    it "should be invalid" do
      invalid_addresses = %w[ sds@sd without @sdss fadsa@ddsa,cds dsd$ds@ssd.com ]
      invalid_addresses.each do | invalid_address |
        @user.email = invalid_address
        expect( @user ).not_to be_valid
      end
    end

  end

  describe "when email is valid" do
    it "should be valid" do
      valid_addresses = %w[ h@haha.com hh@h.in A+B@dd.COm ffd@in.in.in ]
      valid_addresses.each do | valid_address |
        @user.email = valid_address
        expect( @user ).to be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      dup_user = @user.dup
      dup_user.email = @user.email.upcase
      dup_user.save
    end
    it { should_not be_valid}
  end


end
