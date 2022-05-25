class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale
  protect_from_forgery unless: -> { request.format.json? }

  def extr_locale_in_accept_lang
    locale = params[:locale]
    logger.info "In extr_locale_in_accept_lang: locale = #{locale}"
  end

  private

  def set_locale_from_params
    if params[:locale]
      extr_locale_in_accept_lang
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
        logger.info flash.now[:notice]
      else
        flash.now[:alarm] = " #{params[:locale]} Перевод страницы отсутствует"
        logger.error flash.now[:alarm]
      end
      params[:locale]
    end
  end

  def set_locale
    I18n.locale = set_locale_from_params || extract_locale_from_http || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

  # Extract language from request header
  def extract_locale_from_http
    if request.env['HTTP_ACCEPT_LANGUAGE']
      lg = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym
      lg.in?([:en, :ru]) ? lg : nil
    end
  end
end
