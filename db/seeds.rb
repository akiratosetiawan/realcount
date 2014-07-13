require 'csv'



inserts = []

total_tps = 0
puts "Reading new TPS data from @fajran"
#use the newdata file from @fajran 
CSV.foreach(File.path("db/newdata")) do |col|
        
        #check the degree, proceed if only 4
        if col[2] == '4'
                
                #filling the data
                desa = col[3]
                kelurahan_id = col[0]
                jumlah_tps = col[4].to_i

                for tps_id in 1..jumlah_tps
                   #prepare for inserting to database
                   inserts.push("('#{desa}', '#{kelurahan_id}' , '#{tps_id}')")
                end
		total_tps += jumlah_tps
        end
end

puts "Jumlah tps yang akan diinsert", total_tps
CONN = ActiveRecord::Base.connection

puts "Inserting TPS data"
slices = inserts.each_slice(100).to_a

slices.each do |slice|
  sql = "INSERT INTO tps_barus(desa, kelurahan_id, tps_id) VALUES #{slice.join(',')}"
  CONN.execute(sql)
end
puts "Inserted TPS data"
