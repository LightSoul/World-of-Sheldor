class UnitAttribute < ActiveRecord::Base
  attr_accessible :symbol, :name, :description
  
  has_many :bonuses, :foreign_key => "unit_attribute_id", :class_name => "Bonus"
end
