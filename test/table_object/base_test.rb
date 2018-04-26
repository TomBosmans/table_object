# frozen_string_literal: true

require 'test_helper'

# Open dummy/table_objects/user_table.rb to make sense of the tests.
describe TableObject::Base do
  describe '.column' do
    it 'adds a new column to columns array' do
      assert_equal 4, UserTable.columns.count
    end
  end

  describe '.column_names' do
    it 'returns sorted  array of all column names' do
      column_names = %i[email name birth_date log_in_count]
      assert_equal column_names.sort_by(&:to_s), UserTable.column_names
    end
  end

  describe '.columns' do
    it 'is by default an empty array' do
      assert_equal [], TableObject::Base.columns
    end
  end

  describe '.table_action' do
    it 'adds table action to table_actions array' do
      assert_equal 1, UserTable.table_actions.count
    end
  end

  describe '.table_action_names' do
    it 'returns sorted  array of all table action names' do
      table_action_names = %i[new]

      assert_equal table_action_names.sort_by(&:to_s),
                   UserTable.table_action_names
    end
  end

  describe '.table_actions' do
    it 'is by default an empty array' do
      assert_equal [], TableObject::Base.table_actions
    end
  end

  describe '.resource_action' do
    it 'adds resource action to resource_actions array' do
      assert_equal 2, UserTable.resource_actions.count
    end
  end

  describe '.resource_action_names' do
    it 'returns sorted  array of all resource action names' do
      resource_action_names = %i[edit destroy]

      assert_equal resource_action_names.sort_by(&:to_s),
                   UserTable.resource_action_names
    end
  end

  describe '.resource_actions' do
    it 'is by default an empty array' do
      assert_equal [], TableObject::Base.resource_actions
    end
  end

  describe '.model_class' do
    it 'will generate name based on class name' do
      assert_equal User, UserTable.model_class
    end

    it 'can also be set' do
      class OtherUserTable < TableObject::Base
        self.model_class = User
      end

      assert_equal User, OtherUserTable.model_class
    end
  end

  describe '.find_type_for' do
    it 'takes the type from the db' do
      type = UserTable.new({}).find_column(:log_in_count).type
      assert_equal :integer, type

      type = UserTable.new({}).find_column(:birth_date).type
      assert_equal :datetime, type
    end

    it 'can be set' do
      type = UserTable.new({}).find_column(:email).type
      assert_equal :email, type
    end

    it 'defaults to string' do
      type = UserTable.new({}).find_column(:name).type
      assert_equal :string, type
    end
  end

  describe '.default_path' do
    it 'gives all columns a path by default' do
      user = User.create
      column = UserTable.new({}).find_column(:name)
      assert_equal Rails.application.routes.url_helpers.user_path(user),
                   column.path_for(user)
    end

    it 'is not used if column has a specific path' do
      user = User.create(email: 'test@mail.com')
      column = UserTable.new({}).find_column(:email)
      assert_equal user.email,
                   column.path_for(user)
    end
  end

  describe '#find_column' do
    it 'returns column based on name' do
      column = UserTable.new({}).find_column(:name)
      assert_equal :name, column.name
    end
  end

  describe '#find_table_action' do
    it 'returns table action based on name' do
      table_action = UserTable.new({}).find_table_action(:new)
      assert_equal :new, table_action.name
    end
  end

  describe '#find_resource_action' do
    it 'returns resource action based on name' do
      resource_action = UserTable.new({}).find_resource_action(:edit)
      assert_equal :edit, resource_action.name
    end
  end
end
