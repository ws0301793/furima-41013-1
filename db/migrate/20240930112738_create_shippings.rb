class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string     :postcord,           null: false
      t.integer    :prefecture_id,      null: false
      t.string     :municipalities,     null: false
      t.string     :street,             null: false
      t.string     :building,           null: false
      t.string     :telephone_number,   null: false
      t.references :order,              null: false, foreign_key: true
      t.timestamps
    end
  end
end
