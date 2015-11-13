class UnauthorizedController < ActionController::Metal
  include RenderJsonHelper

  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.response_body = build_errors(['Login Failed']).to_json
    self.status = :unauthorized
  end
end
