class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :session_token
      t.text :roles, array: true, default: []
      t.string :member_from, default: '#system'
      t.string :document

      t.timestamps
    end
  end
end
