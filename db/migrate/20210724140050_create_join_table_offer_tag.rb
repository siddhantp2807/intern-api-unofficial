class CreateJoinTableOfferTag < ActiveRecord::Migration[6.1]
  def change
    create_join_table :offers, :tags do |t|
      t.index [:offer_id, :tag_id]
      # t.index [:tag_id, :offer_id]
    end
  end
end
