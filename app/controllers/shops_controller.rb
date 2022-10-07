class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]

  def index
    @shops = policy_scope(Shop)
  end

  def show
    authorize @shop
  end

  def new
    @shop = Shop.new
    authorize @shop
  end

  def create
    @shop = Shop.new(shop_params)
    authorize @shop
    # raise
    if @shop.save!
      redirect_to shops_path, notice: "Your shop has been added!"
    else
      render :new, status: :unprocessable_entity
    end
    ShopAdmin.create!(user: current_user, shop: @shop)
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :summary, :description)
  end
end
