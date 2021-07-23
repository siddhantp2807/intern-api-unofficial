class RemoveOfferIdFromOffers < ActiveRecord::Migration[6.1]
  def change
    remove_column :offers, :offer_id, :integer
  end
end
