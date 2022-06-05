class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :faculty
      t.string :department
      t.string :level
      t.string :terms

      t.timestamps
    end
  end
end
