class CreateSiteUsers < ActiveRecord::Migration
  def change
    create_table :site_users do |t|

      t.timestamps
    end
  end
end
