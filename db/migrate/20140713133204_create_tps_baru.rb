class CreateTpsBaru < ActiveRecord::Migration
  def change
    create_table :tps_barus do |t|
		t.string :desa
		t.string :kelurahan_id
		t.string :tps_id

		t.timestamps
    end
  end
end
