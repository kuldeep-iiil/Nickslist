class CreateGrantorsHistories < ActiveRecord::Migration
  def change
    create_table :grantors_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :GrantorID, :integer, :limit => 11, :null => false
      t.column :FirstName, :string, :limit => 20, :null => false
      t.column :LastName, :string, :limit => 20, :null => false
      t.column :StreetAddress, :string, :limit => 100, :null => false
      t.column :City, :string, :limit => 50, :null => false
      t.column :State, :string, :limit => 20, :null => false
      t.column :ZipCode, :string, :limit => 10, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE grantors_histories
      ADD CONSTRAINT fk_grantors_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE grantors_histories
      ADD CONSTRAINT fk_grantors_histories_GrantorID
      FOREIGN KEY (GrantorID)
      REFERENCES grantors(id)
    SQL
  end
end