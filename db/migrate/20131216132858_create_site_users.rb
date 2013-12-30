class CreateSiteUsers < ActiveRecord::Migration
  def change
    create_table :site_users do |t|
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
  end
end
