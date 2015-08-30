class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.boolean :booked, default: :false
      t.integer :booking_count, default: 0
      t.timestamps null:false
    end
  end
end
