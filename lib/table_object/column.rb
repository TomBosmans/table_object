# frozen_string_literal: true

class TableObject::Column
  attr_accessor :name, :type, :path, :default_path, :value_method, :options

  def initialize(name, options = {})
    self.name = name

    self.type = options[:type] || :string
    self.path = options[:path]
    self.default_path = options[:default_path]
    self.value_method = options[:value_method]

    self.options = options.with_indifferent_access
  end

  def path_for(resource)
    active_path = path || default_path
    active_path.call(resource) if active_path.present?
  end

  def path?
    path.present? || default_path.present?
  end

  def value_for(resource)
    return value_method.call(resource) if value_method.present?
    resource.public_send(name)
  end

  # All the things passed into the options hash, will be returned as if they
  # are attributes.
  #  test_column = TableObject::Column.new('test', 'test?' => true)
  #  test_column.test? => true
  def method_missing(method, *args)
    option = options[method]
    return option if option.present?
    super
  end

  def respond_to?(method, include_private = false)
    options[method].present? ||
      super
  end

  def respond_to_missing?(method, include_private = false)
    options[method].present? ||
      super
  end
end
