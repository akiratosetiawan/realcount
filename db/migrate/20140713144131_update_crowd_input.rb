class UpdateCrowdInput < ActiveRecord::Migration
  def change
	CrowdInput.all.each do |f|
		currentIDKelurahan = Tps.where(:id => f.tps_id).kelurahan_id
		currentIDTps = Tps.where(:id => f.tps_id).tps_id
		
		idTpsBaru = TpsBaru.where(:kelurahan_id => currentIDKelurahan).where(:tps_id => currentIDTps).id
		
		f.update_attribute :tps_id, idTpsBaru
    end
  end
end
