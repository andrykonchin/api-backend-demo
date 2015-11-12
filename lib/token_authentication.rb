module TokenAuthentication
  def self.token_from_request(request)
    header = request.env['HTTP_AUTHORIZATION']
    if header && header[ActionController::HttpAuthentication::Token::TOKEN_REGEX]
      params = ActionController::HttpAuthentication::Token.token_params_from(header)
      params.flatten[1]
    end
  end
end
