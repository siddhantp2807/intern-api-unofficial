class Offer < ApplicationRecord
    has_and_belongs_to_many :tags
    accepts_nested_attributes_for :tags

    def self.add_multiple(arr)
        arr.each do |hash|

            offer = Offer.find_or_create_by(id: hash["id"])
            Tag.add_multiple_tags(hash["tags"])
            hash["tags"] = hash["tags"].map { |tg| Tag.where(name: tg).first }
            offer.update(hash)
        end
    end

    def self.select_by_pay(max_pay, min_pay, obj)
        min_pay = min_pay.nil? ? 0 : min_pay
        
        if max_pay.nil? 
            if obj.min_pay.to_i >= min_pay.to_i 
                return true
            end
        else
            if obj.max_pay.to_i <= max_pay.to_i && obj.min_pay.to_i >= min_pay.to_i 
                return true
            end
        end

        return false
        
    end

    def self.expired?
        if self.exp_stamp > Time.now.to_i
            return false
        else
            return true
        end
    end
end
