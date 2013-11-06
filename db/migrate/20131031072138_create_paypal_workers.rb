class CreatePaypalWorkers < ActiveRecord::Migration
  def change
    create_table :paypal_workers do |t|

      t.timestamps
    end
  end
end
