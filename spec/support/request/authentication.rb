module Request
  module Authentication
    def default_headers_for(user)
      default_headers_for_token(
        user.reload.device_sessions.last.authentication_token)
    end

    def default_headers_for_token(token)
      encoded_token = ActionController::HttpAuthentication::Token.encode_credentials(token)
      {'HTTP_AUTHORIZATION' => encoded_token}
    end
  end
end
