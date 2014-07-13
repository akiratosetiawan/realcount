class UpdateCrowdInput < ActiveRecord::Migration
  def change
        counter  = 0;
	CrowdInput.all.each do |f|
	   	tpsLama = TpsLama.where(:id =>f.tps_id).first

		#Trim leading zero in tps lama
                kelurahan_id = tpsLama.kelurahan_id.to_i
		tps_id = tpsLama.tps_id

                tpsBaru = Tps.where(:kelurahan_id => "#{kelurahan_id}", :tps_id => tps_id).first 
		if tpsBaru == nil
		    print "\nNo record found for desa #{tpsLama.desa}, kelurahan #{tpsLama.kelurahan_id}, tps #{tpsLama.tps_id}"
		    f.update_attribute :tps_id,   0
		else
		    f.update_attribute :tps_id, tpsBaru.id 
		end
		counter += 1;
		if counter % 100 == 0
			print "\nUpdating records # ", counter, " ..."
		end
    	end
  end
end
