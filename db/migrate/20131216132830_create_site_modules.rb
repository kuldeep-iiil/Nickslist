class CreateSiteModules < ActiveRecord::Migration
  def change
    create_table :site_modules do |t|
      t.column :Module, :string, :limit => 20, :null => false
      t.column :Description, :string, :limit => 100, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
