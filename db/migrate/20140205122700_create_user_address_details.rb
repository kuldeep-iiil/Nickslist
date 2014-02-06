class CreateUserAddressDetails < ActiveRecord::Migration
  def change
    create_table :user_address_details do |t|
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :AddressType, :string, :limit => 20, :null => false
      t.column :Address, :string, :limit => 100, :null => false
      t.column :City, :string, :limit => 50, :null => false
      t.column :State, :string, :limit => 20, :null => false
      t.column :ZipCode, :string, :limit => 10, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE user_address_details
      ADD CONSTRAINT fk_user_address_details_UserID
      FOREIGN KEY (UserID)
      REFERENCES subscribed_users(id)
    SQL
  end
end