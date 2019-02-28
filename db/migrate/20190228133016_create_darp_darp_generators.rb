class CreateDarpDarpGenerators < ActiveRecord::Migration[5.0]
  def change
    create_table :darp_darp_generators do |t|
      t.string :uuid
      t.text :content
      t.string :status

      t.timestamps
    end
    add_index :darp_darp_generators, :uuid
  end
end
