class DiscountsController < ApplicationController
  # before_action :find_merchant, only: [:new, :create, :index]
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(percent_discount: (params[:percent_discount].to_f / 100),
                    threshold: params[:threshold],
                    merchant_id: @merchant.id)
    if discount.save
      flash.notice = "Succesfully Created Discount"
      redirect_to merchant_discounts_path(@merchant)
    else
      flash.notice = "All fields must be completed"
      redirect_to new_merchant_discount_path(@merchant)
    end
    
  end
end
