class CreateSiteUserHistories < ActiveRecord::Migration
  def change
    create_table :site_user_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :UserName, :string, :limit => 20, :null => false
      t.column :Password, :string, :limit => 100, :null => false
      t.column :Salt, :string, :limit => 45, :null => false
      t.column :FirstName, :string, :limit => 20, :null => false
      t.column :LastName, :string, :limit => 20, :null => false
      t.column :EmailID, :string, :limit => 50, :null => false
      t.column :IsActivated, :boolean, :null => false
      t.column :IsSuperAdmin, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_user_histories
      ADD CONSTRAINT fk_site_user_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_user_histories
      ADD CONSTRAINT fk_site_user_histories_UserID
      FOREIGN KEY (UserID)
      REFERENCES site_users(id)
    SQL
  end
end