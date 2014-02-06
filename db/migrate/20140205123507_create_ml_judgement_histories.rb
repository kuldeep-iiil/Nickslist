class CreateMlJudgementHistories < ActiveRecord::Migration
  def change
    create_table :ml_judgement_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :AddressID, :integer, :limit => 11, :null => false
      t.column :MLJudgements, :text
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE ml_judgement_histories
      ADD CONSTRAINT fk_ml_judgement_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE ml_judgement_histories
      ADD CONSTRAINT fk_ml_judgement_histories_AddressID
      FOREIGN KEY (AddressID)
      REFERENCES customer_addresses(id)
    SQL
    
  end
end