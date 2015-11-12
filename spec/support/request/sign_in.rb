module Request
  module SignIn
    def sign_in_as_user(opts)
      post '/session', user: {password: opts[:password], email: opts[:email]}
      expect(response.code).to eq '201'

      JSON.parse(response.body)['resource']['authentication_token']
    end
  end
end

