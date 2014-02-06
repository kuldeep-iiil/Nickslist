class CreateCustomerSearches < ActiveRecord::Migration
  def change
    create_table :customer_searches do |t|
      t.column :FirstName, :string, :limit => 50, :null => false
      t.column :LastName, :string, :limit => 50, :null => false
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :SearchDate, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE customer_searches
      ADD CONSTRAINT fk_customer_searches_AddressID
      FOREIGN KEY (AddressID)
      REFERENCES customer_addresses(id)
    SQL
  end
end