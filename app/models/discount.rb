class Discount < ApplicationRecord
  validates_presence_of :percent_discount,
                        :threshold

  belongs_to :merchant
  
end