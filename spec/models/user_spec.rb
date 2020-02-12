require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    before(:each) do
      @user = User.new(
        name: 'John Doe',
        email: 'jd@me.com',
        password: 'wouldntyouliketoknow',
        password_confirmation: 'wouldntyouliketoknow'
      )
    end

    it 'should validate successfully with a valid user' do
      expect(@user).to be_valid
    end

    it 'should fail validation when there is no password' do
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages_for(:password))
        .to include(match(/blank/i))
    end

    it 'should fail validation when password confirmation doesnt match' do
      @user.password_confirmation = 'NotAMatch'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages_for(:password_confirmation))
        .to include(match(/match/i))
    end

    it 'should fail when email already exists (not case sensitive)' do
      existing_user = User.create(
        @user.attributes.merge(
          email: 'jd@me.com',
          password: 'wouldntyouliketoknow',
          password_confirmation: 'wouldntyouliketoknow'
        )
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages_for(:email))
        .to include(match(/taken/i))
    end

    it 'should fail validation when there is no email' do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages_for(:email))
        .to include(match(/blank/i))
    end

    it 'should fail validation when there is no name' do
      @user.name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages_for(:name))
        .to include(match(/blank/i))
    end

    it 'should fail when password is too short' do
      @user.password = 'short'
      @user.password_confirmation = 'short'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages_for(:password))
        .to include(match(/short/i))
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @existing_user = User.create(
        name: 'valid user',
        email: 'jd@me.com',
        password: 'wouldntyouliketoknow',
        password_confirmation: 'wouldntyouliketoknow'
      )
    end

    context 'with valid credentials' do
      it 'returns the user with those credentials' do
        expect(User.authenticate_with_credentials('jd@me.com', 'wouldntyouliketoknow'))
          .to eq(@existing_user)
      end
    end

    context 'with invalid credentials' do
      it 'returns false with a non-existent email' do
        expect(User.authenticate_with_credentials('not_in@database.com', 'wouldntyouliketoknow'))
          .to be false
      end

      it 'returns false with a wrong password' do
        expect(User.authenticate_with_credentials('jd@me.com', 'wrong_password'))
          .to be false
      end
    end
  end
end
