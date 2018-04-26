# frozen_string_literal: true

require 'custom_options'

class TableObject::Column
  include CustomOptions

  attr_accessor :name, :type, :path, :value_method, :options

  def initialize(name, options = {})
    self.name = name

    self.type = options[:type] || :string
    self.path = options[:path]
    self.value_method = options[:value_method]

    self.options = options.with_indifferent_access
  end

  def path_for(resource)
    return unless path.present?
    path.call(resource)
  end

  def value_for(resource)
    return value_method.call(resource) if value_method.present?
    resource.public_send(name)
  end
end
