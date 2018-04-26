# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    create_some_users
    @users = User.all
    @user_table = UserTable.new(@users)
  end

  private

  def create_some_users
    20.times do
      first_name = FIRST_NAMES.sample
      last_name = LAST_NAMES.sample
      email = "#{first_name}.#{last_name}@email.com"
      birth_date = rand(20.years).seconds.ago
      log_in_count = rand(1...42)
      User.create(
        first_name: first_name,
        last_name: last_name,
        email: email,
        birth_date: birth_date,
        log_in_count: log_in_count
      )
    end
  end
end

FIRST_NAMES = %w[
  Liliana
  Ethelene
  Jeana
  Cassandra
  Anitra
  Elmira
  Vickey
  Lizzette
  Bob
  Edna
  Emiko
  Brigitte
  Shawanda
  Charmain
].freeze

LAST_NAMES = %w[
  Fenstermaker
  Larin
  Vang
  Wool
  Grimaldi
  Hemmingway
  Harwood
].freeze
