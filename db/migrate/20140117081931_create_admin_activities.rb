class CreateAdminActivities < ActiveRecord::Migration
  def change
    create_table :admin_activities do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :OPCode, :integer, :limit => 11, :null => false
      t.column :TaskID, :integer, :limit => 11, :null => false
      t.column :DateCreated, :datetime, :null => false
    end
  end
end
