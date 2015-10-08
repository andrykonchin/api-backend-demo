class ApplicationController < ActionController::API
  ActionController::Serialization

  def render_resource_or_errors(resource, options = {})
    if resource.errors.empty?
      render_resource_data(resource, { status: 201 }.merge(options))
    else
      render_resource_errors(resource)
    end
  end

  def render_resource_data(resource, options = {})
    render_json resource, { root: 'resource', status: 200 }.merge(options)
  end

  def render_resources_data(resource, options = {})
    render_json resource, { root: 'resources', status: 200 }.merge(options)
  end

  def render_errors(errors, options = {})
    info = options.delete(:info) || {}
    render_json({ errors: errors, success: false }.merge(info), { status: 422 }.merge(options))
  end

  def render_resource_errors(resource)
    render_errors(resource.errors.full_messages)
  end

  private

  def render_json(data, options)
    render options.merge(json: data)
  end
end
