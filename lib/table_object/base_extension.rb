# frozen_string_literal: true

# instead of doing 'class << self' we extend this file into TableObject::Base
# So these are all class methods.
module TableObject::BaseExtension
  attr_accessor :default_path
  attr_writer :model_class

  # Creates a column and stores it in the columns attribute
  def column(name, options = {})
    options[:path] = default_path unless options[:path].present?
    options[:type] = find_type_for(name) unless options[:type].present?
    options[:label] = find_label_for(name) unless options[:label].present?

    column = TableObject::Column.new(name, options)
    columns << column
    column
  end

  # Return array wiht all the column names
  def column_names
    columns.map(&:name).sort_by(&:to_s)
  end

  def columns
    @columns ||= []
  end

  # Create table action (buttons on the table header)
  def table_action(name, options = {})
    action = TableObject::Action.new(name, options)
    table_actions << action
    action
  end

  # Returns array with all the table action names
  def table_action_names
    table_actions.map(&:name).sort_by(&:to_s)
  end

  def table_actions
    @table_actions ||= []
  end

  # Create resource action (buttons on the row)
  def resource_action(name, options = {})
    action = TableObject::Action.new(name, options)
    resource_actions << action
    action
  end

  # Returns array with all the resource action names
  def resource_action_names
    resource_actions.map(&:name).sort_by(&:to_s)
  end

  def resource_actions
    @resource_actions ||= []
  end

  # if no model_class is set we will generate one based
  # on the table class name
  def model_class
    @model_class ||= generate_model_class
  end

  def url_helper
    Rails.application.routes.url_helpers
  end

  private

  # Examples:
  #   UserTable => User
  #   BooksTable => Book
  def generate_model_class
    name.chomp('Table').singularize.constantize
  end

  def db_column_info_for(column_name)
    hash = model_class.columns_hash.detect { |k, _| k == column_name.to_s }
    hash ? hash.last : nil
  end

  def find_type_for(column_name)
    db_column_info = db_column_info_for(column_name)
    db_column_info ? db_column_info.type : :string
  end

  def find_label_for(column_name)
    model_class.human_attribute_name(column_name)
  end
end
