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
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE liens
      ADD CONSTRAINT fk_liens_AddressID
      FOREIGN KEY (AddressID)
      REFERENCES customer_addresses(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE liens
      ADD CONSTRAINT fk_liens_GrantorID
      FOREIGN KEY (GrantorID)
      REFERENCES grantors(id)
    SQL
  end
end