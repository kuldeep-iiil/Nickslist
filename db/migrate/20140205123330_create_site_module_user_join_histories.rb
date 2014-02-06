class CreateSiteModuleUserJoinHistories < ActiveRecord::Migration
  def change
    create_table :site_module_user_join_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :ModuleID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_module_user_join_histories
      ADD CONSTRAINT fk_site_module_user_join_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_module_user_join_histories
      ADD CONSTRAINT fk_site_module_user_join_histories_ModuleID
      FOREIGN KEY (ModuleID)
      REFERENCES site_modules(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_module_user_join_histories
      ADD CONSTRAINT fk_site_module_user_join_histories_UserID
      FOREIGN KEY (UserID)
      REFERENCES site_users(id)
    SQL
  end
end