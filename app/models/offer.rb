class Offer < ApplicationRecord
    def self.add_multiple(arr)
        arr.each do |hash|

            offer = Offer.find_or_create_by(id: hash["id"])
            offer.update(hash)
        end
    end

end
