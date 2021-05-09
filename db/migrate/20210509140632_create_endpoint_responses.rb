class CreateEndpointResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :endpoint_responses do |t|
      t.references :endpoint

      t.integer :code
      t.jsonb :headers, default: {}
      t.string :body

      t.timestamps
    end
  end
end
