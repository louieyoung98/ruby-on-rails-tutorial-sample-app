# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 50, null: false, default: ""
      t.string :last_name, limit: 50, null: false, default: ""
      t.string :username, limit: 15, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.string :phone_number # Optional
      t.string :email, null: false, default: ""

      t.timestamps
    end
  end
end
