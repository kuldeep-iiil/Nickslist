class CreateSiteContentHistories < ActiveRecord::Migration
  def change
    create_table :site_content_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :PageCode, :integer, :limit => 11, :null => false
      t.column :Title, :string, :limit => 100, :null => false
      t.column :Content, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE site_content_histories
      ADD CONSTRAINT fk_site_content_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
  end
end