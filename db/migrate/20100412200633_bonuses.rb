class Bonuses < ActiveRecord::Migration
  def self.up
    create_table :bonuses do |t|
      t.string :type
      t.string :name
      t.string :description
      t.string :bonusType
      t.integer :value

      t.integer :race_id
      t.integer :unit_attribute_id
      
      t.timestamps
    end

  end

  def self.down
    drop_table :bonuses
  end
end
