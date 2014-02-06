class CreateSiteModuleUserJoins < ActiveRecord::Migration
  def change
    create_table :site_module_user_joins do |t|
      t.column :ModuleID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_module_user_joins
      ADD CONSTRAINT fk_site_module_user_joins_ModuleID
      FOREIGN KEY (ModuleID)
      REFERENCES site_modules(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_module_user_joins
      ADD CONSTRAINT fk_site_module_user_joins_UserID
      FOREIGN KEY (UserID)
      REFERENCES site_users(id)
    SQL
  end
end