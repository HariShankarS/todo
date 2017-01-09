class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :work
      t.boolean :finished
      t.references  :parent
      t.timestamps null: false
    end
  end
end
