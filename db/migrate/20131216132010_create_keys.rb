class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :Key, :string, :limit => 50, :null => false
      t.column :DateCreated, :datetime, :null => false
    end
  end
end
