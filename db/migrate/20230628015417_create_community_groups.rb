class CreateCommunityGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :community_groups do |t|
      t.string :name
      t.string :descritpion
      t.string :hash
      t.string :slug

      t.timestamps
    end
  end
end
