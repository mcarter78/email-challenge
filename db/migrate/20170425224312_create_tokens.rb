class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :nonce
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
