class CreateMlJudgements < ActiveRecord::Migration
  def change
    create_table :ml_judgements do |t|
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :MLJudgements, :text
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
