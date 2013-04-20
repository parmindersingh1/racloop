class CreateSavedRecords < ActiveRecord::Migration
  def change
    create_table :saved_records do |t|

      t.timestamps
    end
  end
end
