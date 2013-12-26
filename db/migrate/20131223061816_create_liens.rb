class CreateLiens < ActiveRecord::Migration
  def change
    create_table :liens do |t|
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :GrantorID, :integer, :limit => 11, :null => false
      t.column :DateIssued, :datetime, :null => false
      t.column :Amount, :float, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
