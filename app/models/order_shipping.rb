class OrderShipping
  include ActiveModel::Model
  attr_accessor :postcord, :prefecture_id, :municipalities, :street, :building, :telephone_number, :order_id, :user_id, :item_id

  with_options presence: true do
    validates :telephone_number, format: {with:/\A\d{10,11}\z/, message: "can't be blank"}
    validates :item_id
    validates :user_id
    validates :postcord, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipalities, {message: "can't be blank"}
    validates :street, {message: "can't be blank"}
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    shipping.create(postcord: postcord, prefecture_id: prefecture_id, municipalities: municipalities, street: street, building: building, telephone_number: telephone_number, order_id: order_id)
  end
end