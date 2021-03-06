# frozen_string_literal: true

require 'test_helper'

describe TableObject::Column do
  let(:column_class) { TableObject::Column }
  let(:column) { TableObject::Column.new(:a_name) }
  let(:resource) { Struct.new(:id).new(1) }
  let(:path) { ->(resource) { "some_path(#{resource.id})" } }

  describe '#path_for(resource)' do
    it 'responds to path_for' do
      assert column.respond_to? :path_for
    end

    it 'returns the path for the resource' do
      column = column_class.new(:hallo_world, path: path)
      assert_equal column.path_for(resource), "some_path(#{resource.id})"
    end

    it 'returns nil if there is no default_paht or path' do
      assert_nil column.path_for(resource)
    end

    it 'returns path if there is also a default_path' do
      column = column_class.new(:hallo_world, path: path, default_path: ->(_) { 'some_path(id: 2)' })
      assert_equal column.path_for(resource), "some_path(#{resource.id})"
    end
  end

  describe '#value_for(resource)' do
    it 'responds to value_for' do
      assert column.respond_to? :value_for
    end

    it 'returns value_method.call for the resource' do
      column.value_method = ->(_) { 'hallo world' }
      assert_equal 'hallo world', column.value_for(resource)
    end

    it 'returns resource.public_send(name) if no value_method is given' do
      column.name = 'id'
      assert_equal resource.public_send(:id), column.value_for(resource)
    end

    it 'returns nil if there is no value' do
      column.value_method = ->(_) { nil }
      assert_nil column.value_for(resource)
    end
  end

  describe 'custom options' do
    it 'you can add custom options' do
      column = column_class.new(:test, 'test?' => true)
      assert column.options['test?']
    end

    it 'can handle strings and symbols as options' do
      column = column_class.new(:test, 'string' => 'string', symbol: 'symbol')
      assert_equal 'string', column.options['string']
      assert_equal 'symbol', column.options[:symbol]
    end
  end
end
