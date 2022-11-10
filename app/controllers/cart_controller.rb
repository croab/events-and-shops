class CartController < ApplicationController
  def show
    @render_cart = false
    @cart = Cart.find_by(id: session[:cart_id])
    authorize @cart
  end
end
