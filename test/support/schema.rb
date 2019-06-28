# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users do |t|
    t.string :first_name
    t.string :last_name
    t.string :email
    t.string :role

    t.timestamps
  end

  create_table :contacts do |t|
    t.string :first_name
    t.string :last_name
    t.string :email

    t.references :user

    t.timestamps
  end
end
