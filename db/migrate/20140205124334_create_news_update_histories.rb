class CreateNewsUpdateHistories < ActiveRecord::Migration
  def change
    create_table :news_update_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :Comments, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE news_update_histories
      ADD CONSTRAINT fk_news_update_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
  end
end