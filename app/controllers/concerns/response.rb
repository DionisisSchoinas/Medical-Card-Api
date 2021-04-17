# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok, include = nil, fields = nil)
    if include.nil?
      render json: object, status: status
    elsif fields.nil?
      render json: object, include: include, status: status
    else
      render json: object, include: include, fields: fields, status: status
    end
  end
end
