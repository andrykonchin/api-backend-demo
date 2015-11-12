require 'rails_helper'

describe 'User session' do
  describe 'POST /session' do
    let!(:user) { create(:user, password: password) }
    let(:password) { '12345678' }

    it 'creates new user session' do
      post '/session', user: {password: '12345678', email: user.email}
      expect(response.code).to eq '201'
      token = JSON.parse(response.body)['resource']['authentication_token']

      get '/profile', authentication_token: token
      expect(response.code).to eq '200'
    end

    context 'when user signs in again' do
      it 'creates new session' do
        open_session do |session|
          session.post '/session', user: {password: password, email: user.email}
          expect(session.response.code).to eq '201'
        end

        open_session do |session|
          session.post '/session', user: {password: password, email: user.email}
          expect(session.response.code).to eq '201'
          token = JSON.parse(session.response.body)['resource']['authentication_token']

          session.get '/profile', authentication_token: token
          expect(session.response.code).to eq '200'
        end
      end

      it 'can use both sessions independently at the same time' do
        session1 = open_session
        session1.post '/session', user: {password: password, email: user.email}
        expect(session1.response.code).to eq '201'
        token1 = JSON.parse(session1.response.body)['resource']['authentication_token']

        session2 = open_session
        session2.post '/session', user: {password: password, email: user.email}
        expect(session2.response.code).to eq '201'
        token2 = JSON.parse(session2.response.body)['resource']['authentication_token']

        session1.get '/profile', authentication_token: token1
        expect(session1.response.code).to eq '200'

        session2.get '/profile', authentication_token: token2
        expect(session2.response.code).to eq '200'
      end
    end
  end

  describe 'DELETE /session' do
    let!(:user) { create(:user, password: password) }
    let(:password) { '12345678' }

    it 'removes current user session' do
      post '/session', user: {password: password, email: user.email}
      expect(response.code).to eq '201'
      token = JSON.parse(response.body)['resource']['authentication_token']

      get '/profile', authentication_token: token
      expect(response.code).to eq '200'

      delete '/session', authentication_token: token
      expect(response.code).to eq '200'

      get '/profile', authentication_token: token
      expect(response.code).to eq '401'
    end
  end
end

