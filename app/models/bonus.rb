# type (inheritance) can be: RaceBonus, ClassBonus, UnitTypeBonus
# bonusType can be: add_absolute, add_percent, substract_absolut, substract_percent

class Bonus < ActiveRecord::Base
  set_table_name "bonuses"
  
  attr_accessible :name, :description, :bonusType, :value
  
  belongs_to :unit_attribute
end
