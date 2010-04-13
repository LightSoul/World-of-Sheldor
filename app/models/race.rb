class Race < ActiveRecord::Base
  attr_accessible :name, :description, :template

  has_many :bonuses, :foreign_key => "race_id", :class_name => "Bonus"
end
