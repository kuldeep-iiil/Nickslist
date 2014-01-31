class CreateOperationLists < ActiveRecord::Migration
  def change
    create_table :operation_lists do |t|
      t.column :OPCode, :integer, :limit => 11, :null => false
      t.column :Operation, :string, :limit => 200, :null => false
      t.column :DateCreated, :datetime, :null => false
    end
  end
end
