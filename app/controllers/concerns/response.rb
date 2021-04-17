# app/controllers/concerns/response.rb
module Response
  # options =
  # => status
  # => include
  # => fields
  # => meta
  # => serializer
  # => each_serializer
  def json_response(object, options = {})

    render_options = {json: object, adapter: :json}
    render_options[:status] = options[:status] || :ok
    render_options[:include] = options[:include] unless options[:include].nil?
    render_options[:fields] = options[:fields] unless options[:fields].nil?
    render_options[:meta] = options[:meta] unless options[:meta].nil?
    render_options[:serializer] = options[:serializer] unless options[:serializer].nil?
    render_options[:each_serializer] = options[:each_serializer] unless options[:each_serializer].nil?

    render render_options
  end
end
