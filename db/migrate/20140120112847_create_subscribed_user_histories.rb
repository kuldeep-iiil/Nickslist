class CreateSubscribedUserHistories < ActiveRecord::Migration
  def change
    create_table :subscribed_user_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :UserName, :string, :limit => 20, :null => false
      t.column :Password, :string, :limit => 100, :null => false
      t.column :Salt, :string, :limit => 45, :null => false
      t.column :FirstName, :string, :limit => 20, :null => false
      t.column :MiddleName, :string, :limit => 20
      t.column :LastName, :string, :limit => 20, :null => false
      t.column :EmailID, :string, :limit => 50, :null => false
      t.column :CompanyName, :string, :limit => 100, :null => false
      t.column :IncorporationType, :string, :limit => 20, :null => false
      t.column :ContactNumber, :string, :limit => 20, :null => false
      t.column :LicenseNumber, :string, :limit => 20, :null => false
      t.column :AuthCodeUsed, :string, :limit => 45
      t.column :IsActivated, :boolean, :null => false
      t.column :IsSubscribed, :boolean, :null => false
      t.column :IsNotification, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
