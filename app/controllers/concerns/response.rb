# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok, include = nil)
    if include.nil?
      render json: object, status: status
    else
      render json: object, include: include, status: status
    end
  end
end
