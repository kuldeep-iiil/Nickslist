class CreateAdminLoginReports < ActiveRecord::Migration
  def change
    create_table :admin_login_reports do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :LoginDateTime, :datetime, :null => false
      t.column :LogOutDateTime, :datetime
    end
  end
end