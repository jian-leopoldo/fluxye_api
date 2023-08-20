class CreateCommunityGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :community_groups do |t|
      t.string :name
      t.string :description
      t.string :slug
      t.references :user, null: false, foreign_key: true, type: :uuid


      t.timestamps
    end
  end
end
