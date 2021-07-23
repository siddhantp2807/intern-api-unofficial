class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.string :base
      t.string :header
      t.string :url
      t.integer :offer_id
      t.string :co_name
      t.string :locus, array: true
      t.string :begin_date, array: true
      t.string :duration
      t.string :pay_struct
      t.string :min_pay
      t.string :max_pay
      t.string :exp_str
      t.timestamp :exp_stamp
      t.string :co_url
      t.string :tags, array: true
      t.integer :applicants
      t.integer :openings

      t.timestamps
    end
  end
end
