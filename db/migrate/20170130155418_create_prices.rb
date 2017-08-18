class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.date :start_date
      t.date :end_date
      t.integer :min_days
      t.decimal :weekly_price
      t.decimal :extra_price

      t.timestamps
    end
  end
end
