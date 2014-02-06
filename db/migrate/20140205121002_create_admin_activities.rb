class CreateAdminActivities < ActiveRecord::Migration
  def change
    create_table :admin_activities do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :OPCode, :integer, :limit => 11, :null => false
      t.column :TaskID, :integer, :limit => 11, :null => false
      t.column :DateCreated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE admin_activities
      ADD CONSTRAINT fk_admin_activities_UserID
      FOREIGN KEY (UserID)
      REFERENCES site_users(id)
    SQL
  end
end