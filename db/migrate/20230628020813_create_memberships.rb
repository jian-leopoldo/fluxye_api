class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :community, null: false, foreign_key: true,  type: :uuid
      t.text :roles, array: true, default: []


      t.timestamps
    end
  end
end
