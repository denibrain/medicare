class CreateDiagnoses < ActiveRecord::Migration
  def change
    create_table :diagnoses do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
