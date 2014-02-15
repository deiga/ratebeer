class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.references :beer, index: true

      t.timestamps
    end
  end
end
