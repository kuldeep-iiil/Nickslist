class CreateLiensHistories < ActiveRecord::Migration
  def change
    create_table :liens_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :GrantorID, :integer, :limit => 11, :null => false
      t.column :DateIssued, :datetime, :null => false
      t.column :Amount, :float, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
