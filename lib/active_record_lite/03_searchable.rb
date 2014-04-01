require_relative 'db_connection'
require_relative '02_sql_object'

module Searchable
  def where(params)
    search_terms = params.keys.map { |param| "#{ param } = ?" }.join(" AND ")

   #update_line = self.class.columns.map { |attr| "#{ attr } = ?" }.join(", ")

    meow = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{ table_name }
      WHERE
        #{ search_terms}
    SQL

    parse_all(meow)
  end
end

class SQLObject
  extend Searchable
end
