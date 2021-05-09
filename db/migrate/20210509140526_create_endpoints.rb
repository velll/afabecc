class CreateEndpoints < ActiveRecord::Migration[6.0]
  def change
    create_table :endpoints do |t|
      t.string :verb
      t.string :path

      t.timestamps
    end
  end
end
