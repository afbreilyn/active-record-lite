require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'


class MassObject

  def self.parse_all(results)
    objects = []

    results.each do |result|
      objects << self.new(result)
    end

    objects
  end
end

class SQLObject < MassObject

  def self.my_attr_accessor(*names)

    names.each do |name|
      define_method(name) do
        self.attributes[name.to_sym]
      end
    end

    names.each do |name|
      define_method("#{name}=") do |value|
        self.attributes[name.to_sym] = value
      end
    end
  end

  def self.columns
    col_arr = DBConnection.execute2("SELECT * FROM #{@table_name}")[0]

    col_arr.each do |column|
      my_attr_accessor(column)
    end

  end

  def self.table_name=(table_name = nil)
    @table_name = table_name
  end

  def self.table_name
    # gets the table name
    if @table_name == nil
      @table_name = "#{self}".tableize
    else
      @table_name
    end
  end

  def self.all #????????????????????????

    meow = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
      SQL

    # parse_all(meow)
  end

  def self.find(id)
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def insert
    # ...
  end
  #
  # def initialize({})
  #   # ...
  # end

  def save
    # ...
  end

  def update
    # ...
  end

  def attribute_values
    # ...
  end
end
