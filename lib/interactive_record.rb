require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = "PRAGMA table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    col_names = []

    table_info.each do |column|
      col_names << column["name"]
    end
    col_names.compact
  end

  def initialize(attributes={})
    attributes.each do |key, values|
      self.send("#{key}=",values)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

end
