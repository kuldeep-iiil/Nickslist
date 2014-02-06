class CreateUserLoginReports < ActiveRecord::Migration
  def change
    create_table :user_login_reports do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :LoginDateTime, :datetime, :null => false
      t.column :LogOutDateTime, :datetime
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE user_login_reports
      ADD CONSTRAINT fk_user_login_reports_UserID
      FOREIGN KEY (UserID)
      REFERENCES subscribed_users(id)
    SQL
  end
end