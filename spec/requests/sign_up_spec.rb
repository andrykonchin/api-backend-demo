require 'rails_helper'

describe 'User Sign Up' do
  describe 'POST /users' do
    it 'let user to sign up' do
      post '/users', user: {password: '12345678', email: 'user@gmail.com'}
      expect(response.code).to eq '201'
    end

    it 'allows to sign in with new credentials' do
      post '/users', user: {password: '12345678', email: 'user@gmail.com'}
      post '/session', user: {password: '12345678', email: 'user@gmail.com'}
      expect(response.code).to eq '201'
    end
  end
end

