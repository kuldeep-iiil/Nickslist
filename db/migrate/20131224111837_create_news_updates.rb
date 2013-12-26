class CreateNewsUpdates < ActiveRecord::Migration
  def change
    create_table :news_updates do |t|
      t.column :Comments, :text, :null =>false
      t.column :IsEnabled, :boolean, :null => false
      t.column :DateCreated, :datetime, :null => false
      t.column :DateUpdated, :datetime, :null => false
    end
  end
end
