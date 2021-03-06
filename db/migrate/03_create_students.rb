class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :grade_level
      t.string :contact_name
      t.string :contact_phone
    end
  end
end
