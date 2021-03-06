class CreateTestimonialHistories < ActiveRecord::Migration
  def change
    create_table :testimonial_histories do |t|
      t.column :ReportID, :integer, :limit => 11, :null => false
      t.column :FirstName, :string, :limit => 20, :null => false
      t.column :LastName, :string, :limit => 20, :null => false
      t.column :Occupation, :string, :limit => 20, :null => false
      t.column :Comments, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
    
    # add a foreign key
    execute <<-SQL
    ALTER TABLE testimonial_histories
      ADD CONSTRAINT fk_testimonial_histories_ReportID
      FOREIGN KEY (ReportID)
      REFERENCES admin_activities(id)
    SQL
  end
end