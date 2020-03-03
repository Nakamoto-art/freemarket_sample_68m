class Item < ApplicationRecord

  # 商品が削除された際に画像も一緒に削除されるようにするため
  has_many :images, dependent: :destroy
  # imageをitemにネストさせる表記
  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  has_many :comments
  has_one :purchase

  validates :name, :text, :price, presence: true
  validates :images, presence: true

  has_one :address

  belongs_to :category

  # 外部キーが空でも許可する記述
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand

  belongs_to :status

  belongs_to :seller, class_name: "User", optional: true, foreign_key: "seller_id"


  belongs_to :buyer, class_name: "User", optional: true, foreign_key: "buyer_id"
end