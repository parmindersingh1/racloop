class CreateUserInformations < ActiveRecord::Migration
  def change
    create_table :user_informations do |t|

      t.timestamps
    end
  end
end
