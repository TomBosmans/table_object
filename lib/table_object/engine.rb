# frozen_string_literal: true

module TableObject
  class Engine < ::Rails::Engine
    isolate_namespace TableObject
  end
end

require 'table_object/base'
