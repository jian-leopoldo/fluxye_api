class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :type
      t.string :description
      t.references :community, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
