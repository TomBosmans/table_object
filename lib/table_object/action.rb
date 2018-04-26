# frozen_string_literal: true

require 'custom_options'

class TableObject::Action
  include CustomOptions

  attr_accessor :name, :options

  def initialize(name, options = {})
    self.name = name
    self.options = options.with_indifferent_access
  end
end
