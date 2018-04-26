# frozen_string_literal: true

require 'test_helper'

describe TableObject::Action do
  let(:action_class) { TableObject::Action }
  let(:action) { TableObject::Action.new(:a_name) }
  let(:resource) { Struct.new(:id).new(1) }

  describe 'custom options' do
    it 'can be called as if it is a method' do
      action = action_class.new(:test, 'test?' => true)
      assert action.test?
    end

    it 'can handle strings and symbols as options' do
      action = action_class.new(:test, 'string' => 'string', symbol: 'symbol')
      assert_equal 'string', action.string
      assert_equal 'symbol', action.symbol
    end
  end
end

