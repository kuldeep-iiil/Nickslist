class CreatePaypalWorkerrs < ActiveRecord::Migration
  def change
    create_table :paypal_workerrs do |t|

      t.timestamps
    end
  end
end
