class Tag < ApplicationRecord
    has_and_belongs_to_many :offers

    def self.add_multiple_tags(arr)
        x = []
        arr.each do |elmt|
            tag = Tag.find_or_create_by(name: elmt)
            tag.update({ name: elmt })
        end
        x
    end
end