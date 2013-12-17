class CreateCustomerSearches < ActiveRecord::Migration
  def change
    create_table :customer_searches do |t|
      t.column :FirstName, :string, :limit => 50, :null => false
      t.column :LastName, :string, :limit => 50, :null => false
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :SearchDate, :datetime, :null => false
    end
  end
end
