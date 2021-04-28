class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  def page_params
    p = { page: 1, per_page: 20 }
    p[:page] = params[:page] unless params[:page].nil? || params[:page].to_i < 1
    p[:per_page] = params[:per_page] unless params[:per_page].nil? || params[:per_page].to_i < 1
    return p
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
