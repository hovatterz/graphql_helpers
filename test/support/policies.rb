# frozen_string_literal: true

class BasePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end

class UserPolicy < BasePolicy
  def base_attributes
    [
      :email,
      :first_name,
      :last_name,
      contacts_attributes: %i[
        email
        first_name
        last_name
      ]
    ]
  end

  def permitted_attributes
    return base_attributes + %i[role] if user.role == 'admin'

    base_attributes
  end
end

class ContactPolicy < BasePolicy
  class Scope < Scope
    def resolve
      return scope.all if user.role == 'admin'

      user.contacts
    end
  end

  def base_attributes
    %i[first_name last_name email]
  end

  def permitted_attributes
    return base_attributes + %i[user_id] if user.role == 'admin'

    base_attributes
  end

  def index?
    true
  end

  def show?
    return true if user.role == 'admin'

    user == record.user
  end

  def create?
    true
  end

  def update?
    return true if user.role == 'admin'

    user == record.user
  end
end

class SchoolBusPolicy < BasePolicy
  def permitted_attributes
    %i[wheels]
  end

  def create?
    true
  end
end
