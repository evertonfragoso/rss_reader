require 'active_record'

MIGRATIONS = [
  {
    table_name: :feeds,
    columns: [
      {
        name: :name,
        type: :string
      },
      {
        name: :url,
        type: :string
      },
      {
        name: :timestamps
      }
    ]
  }
]

require File.expand_path('../../db', __FILE__) + '/connection'

MIGRATIONS.each do |mig|
  ActiveRecord::Migration.create_table mig[:table_name] do |t|
    mig[:columns].each do |col|
      if col[:name] == :timestamps
        t.timestamps
      else
        t.column col[:name], col[:type]
      end
    end
  end
end

# TODO: create a way to change tables
