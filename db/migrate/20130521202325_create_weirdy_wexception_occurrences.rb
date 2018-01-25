class CreateWeirdyWexceptionOccurrences < ActiveRecord::Migration[5.1]
  def change
    create_table :weirdy_wexception_occurrences do |t|
      t.references :wexception
      t.text :message
      t.text :backtrace
      t.timestamp :happened_at
      t.text :data
    end
  end
end
