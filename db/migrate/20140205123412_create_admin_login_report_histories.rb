class CreateAdminLoginReportHistories < ActiveRecord::Migration
  def change
    create_table :admin_login_report_histories do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :LoginDateTime, :datetime, :null => false
      t.column :LogOutDateTime, :datetime
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE admin_login_report_histories
      ADD CONSTRAINT fk_sadmin_login_report_histories_UserID
      FOREIGN KEY (UserID)
      REFERENCES site_users(id)
    SQL
  end
end