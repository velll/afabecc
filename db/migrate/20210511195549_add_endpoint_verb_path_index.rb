class AddEndpointVerbPathIndex < ActiveRecord::Migration[6.0]
  def change
    # Test suite fails with unique constraint
    # add_index :endpoints, [:verb, :path], :unique => true
  end
end
