require 'csv'

indexTPS = Array.new(500000, 0)

CONN = ActiveRecord::Base.connection

puts "Inserting new TPS data"

#use the newdata file from @fajran 
CSV.foreach(File.path("db/newdata")) do |col|
	
	#check the degree, proceed if only 4
	if col[2] == '4'
		#increment the counter for index
		indexTPS[col[1].to_i] += 1
		
		#filling the data
		desa = col[3]
		kelurahan_id = col[1]
		tps_id = indexTPS[col[1].to_i].to_s
		
		#prepare for inserting to database
		inserts.push("('#{desa}', '#{kelurahan_id}' , '#{tps_id}')")
		sql = "INSERT INTO tps_barus(desa, kelurahan_id, tps_id) VALUES ({desa}, {kelurahan_id}, {tps_id})"
		CONN.execute(sql)
	end
end

puts "Inserted new TPS data"