class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  protected
  
  def set_locale
    http_accept_language = request.env['HTTP_ACCEPT_LANGUAGE'] || 'en'
    I18n.locale = http_accept_language.scan(/^[a-z]{2}/).first.downcase.to_sym
    I18n.locale = :en if I18n.locale != :fr
    locale = params[:locale]
    I18n.locale = locale.to_sym if locale && locale.to_s.size == 2
  end
end
