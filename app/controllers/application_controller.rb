class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Rails thinks we are on HTTP but our forwarded origin header is HTTPS,
  # but only on staging, so anyway disable it
  self.forgery_protection_origin_check = Rails.env.production?

protected

  def current_cart
    @current_cart ||= begin
                        Order.find(cookies.signed[:cart_id])
                      rescue
                        Order.create.try do |cart|
                          cookies.permanent.signed[:cart_id] = cart.id
                        end
                      end
  end
  helper_method :current_cart

  def default_url_options options = { }
    options.merge protocol: Rails.env.production? ? 'http' : 'https'
  end

  def find_product
    @product ||= Product.find_by! name: params[:product]&.titleize
  end
end
