require 'csv'

inserts = []

#use the newdata file from @fajran 
CSV.foreach(File.path("db/newdata")) do |col|
	
	#check the degree, proceed if only 4
	if col[2] == '4'
		#increment the counter for index
		indexTPS[col[1].to_i] += 1
		
		#filling the data
		desa = col[3]
		kelurahan_id = col[0]
		tps_id = indexTPS[col[1].to_i].to_s
		
		#prepare for inserting to database
		inserts.push("('#{desa}', '#{kelurahan_id}' , '#{tps_id}')")
	end
end

CONN = ActiveRecord::Base.connection

puts "Inserting TPS data"
slices = inserts.each_slice(100).to_a
slices.each do |slice|
  sql = "INSERT INTO tps(desa, kelurahan_id, tps_id) VALUES #{slice.join(',')}"
  CONN.execute(sql)
end
puts "Inserted TPS data"