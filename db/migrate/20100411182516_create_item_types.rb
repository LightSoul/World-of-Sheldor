class CreateItemTypes < ActiveRecord::Migration
  def self.up
    create_table :item_types do |t|
      t.string :name
      t.string :description
      t.boolean :template

      t.timestamps
    end
  end

  def self.down
    drop_table :item_types
  end
end
