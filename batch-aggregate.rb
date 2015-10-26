f = File.open("results/results.csv", "w") do |f|

	Dir.glob("results/**/results.csv").each do |x|
		f << File.read(x)
	end
	
end