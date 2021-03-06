class CreateDefendantsHistories < ActiveRecord::Migration
  def change
    create_table :defendants_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :DefendantID, :integer, :limit => 11, :null => false
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
    ALTER TABLE defendants_histories
      ADD CONSTRAINT fk_defendants_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE defendants_histories
      ADD CONSTRAINT fk_defendants_histories_DefendantID
      FOREIGN KEY (DefendantID)
      REFERENCES defendants(id)
    SQL
  end
end