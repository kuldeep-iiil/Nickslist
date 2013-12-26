class CreateCourtProceedings < ActiveRecord::Migration
  def change
    create_table :court_proceedings do |t|
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :PlaintiffID, :integer, :limit => 11, :null => false
      t.column :DefendantID, :integer, :limit => 11, :null => false
      t.column :CaseType, :string, :limit => 30, :null => false
      t.column :CourtHearingDate, :datetime, :null => false
      t.column :DateFiled, :datetime, :null => false
      t.column :AmountAwarded, :float, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
