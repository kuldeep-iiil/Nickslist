class CreateFaqHistories < ActiveRecord::Migration
  def change
    create_table :faq_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :Question, :string, :limit => 200, :null => false
      t.column :Answers, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE faq_histories
      ADD CONSTRAINT fk_faq_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
  end
end