class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :title
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
