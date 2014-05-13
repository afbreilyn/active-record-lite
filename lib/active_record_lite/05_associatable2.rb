require_relative '04_associatable'
require 'debugger'
# Phase V
module Associatable

  def has_one_through(name, through_name, source_name)

    define_method(name) do
      #debugger
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_table = through_options.table_name
      through_fk = through_options.foreign_key
      through_pk = through_options.primary_key

      source_table = source_options.table_name
      source_fk = source_options.foreign_key
      source_pk = source_options.primary_key

      key = self.send(through_fk)
      result = DBConnection.execute(<<-SQL, key)
        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table}
        ON
          #{through_table}.#{source_fk} = #{source_table}.#{source_pk}
        WHERE
          #{through_table}.#{through_pk} = ?
      SQL

      source_options.model_class.parse_all(result).first
    end
  end
end
