class UnitClass < ActiveRecord::Base
  set_table_name "classes"
  
  attr_accessible :name, :description, :template

end
