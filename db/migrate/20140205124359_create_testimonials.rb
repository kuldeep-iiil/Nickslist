class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.column :FirstName, :string, :limit => 20, :null => false
      t.column :LastName, :string, :limit => 20, :null => false
      t.column :Occupation, :string, :limit => 20, :null => false
      t.column :Comments, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end