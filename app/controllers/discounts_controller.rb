class DiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_discount, only: [:show, :edit, :update]
  
  def index
  end

  def new
  end

  def create
    discount = Discount.new(percent_discount: (params[:percent_discount]),
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

  def edit
  end

  def update
    if @discount.update(discount_params)
      flash.notice = "Succesfully Updated Discount"
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      flash.notice = "All fields must be completed"
      redirect_to edit_merchant_discount_path(@merchant, @discount)
    end
  end

  private

  def discount_params
    params.require(:discount).permit(:percent_discount, :threshold, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @discount = Discount.find(params[:id])
  end
end
