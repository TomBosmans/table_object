module CustomOptions
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
