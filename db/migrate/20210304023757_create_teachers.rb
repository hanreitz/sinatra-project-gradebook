class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :password_digest
    end
  end
end
