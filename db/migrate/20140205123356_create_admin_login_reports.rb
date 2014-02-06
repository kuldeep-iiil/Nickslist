class CreateAdminLoginReports < ActiveRecord::Migration
  def change
    create_table :admin_login_reports do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :LoginDateTime, :datetime, :null => false
      t.column :LogOutDateTime, :datetime
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE admin_login_reports
      ADD CONSTRAINT fk_admin_login_reports_UserID
      FOREIGN KEY (UserID)
      REFERENCES site_users(id)
    SQL
  end
end