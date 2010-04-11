class CreateUserSelfRelationship < ActiveRecord::Migration

  def self.up
    
    create_table :relationships, :force => true do |t|
    t.integer :user1_id, :null => false
    t.integer :user2_id, :null => false
    t.boolean :pending
    
    end
    add_index :relationships, [:user1_id, :user2_id], :unique => true
    add_index :relationships, :user1_id, :unique => false
  end

  def self.down
    drop_table :relationships
  end
end
