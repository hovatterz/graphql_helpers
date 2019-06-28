# frozen_string_literal: true

ActiveRecord::Base.transaction do
  User.create!(
    first_name: 'Admin',
    last_name: 'User',
    email: 'adminuser@test.com',
    role: 'admin'
  )

  user_one = User.create!(
    first_name: 'First',
    last_name: 'User',
    email: 'firstuser@test.com',
    role: 'user'
  )

  user_two = User.create!(
    first_name: 'Second',
    last_name: 'User',
    email: 'seconduser@test.com',
    role: 'user'
  )

  Contact.create!(
    first_name: 'Test',
    last_name: 'Person1',
    email: 'testperson1@test.com',
    user: user_one
  )

  Contact.create!(
    first_name: 'Test',
    last_name: 'Person2',
    email: 'testperson2@test.com',
    user: user_two
  )
end
