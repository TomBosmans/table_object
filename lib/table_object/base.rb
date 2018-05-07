# frozen_string_literal: true

require 'table_object/column'
require 'table_object/action'
require 'table_object/base_extension'

class TableObject::Base
  extend TableObject::BaseExtension

  attr_accessor :resources,
                :columns,
                :table_actions, :resource_actions,
                :default_path,
                :name

  def initialize(resources)
    self.resources = resources

    self.columns = self.class.columns.collect { |c| c.dup }
    self.table_actions = self.class.table_actions.collect { |a| a.dup  }
    self.resource_actions = self.class.resource_actions.collect { |a| a.dup }
    self.default_path = self.class.default_path
  end

  # Find a column based on the given name
  def find_column(name)
    columns.detect { |column| column.name.to_sym == name.to_sym }
  end

  # Find table action by name
  def find_table_action(name)
    table_actions.detect { |action| action.name.to_sym == name.to_sym }
  end

  # Find Resource action by name
  def find_resource_action(name)
    resource_actions.detect { |action| action.name.to_sym == name.to_sym }
  end

  def name
    @name ||= generate_table_name
  end

  private

  def generate_table_name
    self.class.name.underscore
  end
end
