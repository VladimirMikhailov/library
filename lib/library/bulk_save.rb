module Library
  class BulkSave
    QUERY = "COPY %{table} (%{columns}) FROM STDIN WITH csv"

    attr_reader :query
    private :query

    def initialize(table:, columns: [:name])
      @query = QUERY % { table: table, columns: columns.join(",") }
    end

    def save(data)
      return unless data

      connection.copy_data(query) do
        connection.put_copy_data(data)
      end
    end

    private

    def connection
      ActiveRecord::Base.connection.raw_connection
    end
  end
end
