class ApplicationController < ActionController::Base
  # CALLBACKS ===============
  # For Devise
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # For Pundit
  include Pundit::Authorization
  # For Cart mechanism
  before_action :set_render_cart
  before_action :initialize_cart

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # METHODS ===============
  # Devise config
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  # Pundit - rescue the error on non-authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  # Cart
  # Set rendering of cart to true to show cart in top corner
  def set_render_cart
    @render_cart = true
  end

  # Set up the cart
  def initialize_cart
    # If no @cart variable yet exists try to find cart with id and set it to @cart
    @cart ||= Cart.find_by(id: session[:cart_id])
    # However, if this returns nil, try to create a cart
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  private
  # No authorization for devise controllers or certain other pages
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
