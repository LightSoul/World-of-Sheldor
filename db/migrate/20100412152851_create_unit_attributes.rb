class CreateUnitAttributes < ActiveRecord::Migration
  def self.up
    create_table :unit_attributes do |t|
      t.string :symbol
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :unit_attributes
  end
end
