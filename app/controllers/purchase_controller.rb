class PurchaseController < ApplicationController
  before_action :set_card, only: [:index, :pay]
  require 'payjp'

  def index
    if card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
    @addresses= Address.find_by(user_id: current_user.id)
    @items = Item.find_by(user_id: current_user.id)
    @images = Image.find_by(user_id: current_user.id)
  end

  def pay
    item = Item.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: 20000,
      customer: card.customer_id,
      currency: 'jpy',
    )
    redirect_to root_path
  end

  def set_card
    card = Card.find_by(user_id: current_user.id)
  end

end
