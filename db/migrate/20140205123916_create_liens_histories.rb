class CreateLiensHistories < ActiveRecord::Migration
  def change
    create_table :liens_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :GrantorID, :integer, :limit => 11, :null => false
      t.column :DateIssued, :datetime, :null => false
      t.column :Amount, :float, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE liens_histories
      ADD CONSTRAINT fk_liens_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE liens_histories
      ADD CONSTRAINT fk_liens_histories_AddressID
      FOREIGN KEY (AddressID)
      REFERENCES customer_addresses(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE liens_histories
      ADD CONSTRAINT fk_liens_histories_GrantorID
      FOREIGN KEY (GrantorID)
      REFERENCES grantors(id)
    SQL
  end
end