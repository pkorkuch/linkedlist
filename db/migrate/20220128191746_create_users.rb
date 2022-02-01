class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension(:citext)
    create_table :users do |t|
      t.string :name
      t.citext :email

      t.timestamps
    end
  end
end
