class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index, :destroy]
  before_action :find_discount, only: [:show]
  
  def index
  end

  def new
  end

  def create
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

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  def show
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @discount = Discount.find(params[:id])
  end
end
