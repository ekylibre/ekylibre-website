class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  protected
  
  def set_locale
    # request.env['HTTP_ACCEPT_LANGUAGE'].inspect
    I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.downcase.to_sym
    if I18n.locale != :fr
      I18n.locale = :en
    end
    I18n.locale = params[:locale].to_sym if params[:locale].to_s.size == 2
  end
end
