class CreateUserAddressDetailHistories < ActiveRecord::Migration
  def change
    create_table :user_address_detail_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :UserID, :integer, :limit => 11, :null => false
      t.column :AddressType, :string, :limit => 20, :null => false
      t.column :Address, :string, :limit => 100, :null => false
      t.column :City, :string, :limit => 50, :null => false
      t.column :State, :string, :limit => 20, :null => false
      t.column :ZipCode, :string, :limit => 10, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
