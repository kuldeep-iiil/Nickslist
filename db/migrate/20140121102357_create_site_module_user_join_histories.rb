class CreateSiteModuleUserJoinHistories < ActiveRecord::Migration
  def change
    create_table :site_module_user_join_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :ModuleID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
