class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.string :name
      t.string :email
      t.text :body
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
