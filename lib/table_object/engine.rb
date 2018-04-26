# frozen_string_literal: true

require 'table_object/base'

module TableObject
  class Engine < ::Rails::Engine
    isolate_namespace TableObject
  end
end
