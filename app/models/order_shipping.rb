class OrderShipping
  include ActiveModel::Model
  attr_accessor :postcord, :prefecture_id, :municipalities, :street, :building, :telephone_number, :order_id, :user_id, :item_id
end