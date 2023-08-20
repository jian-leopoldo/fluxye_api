class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :url
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :primary_color
      t.string :secondary_color
      t.string :slug

      t.timestamps
    end
  end
end
