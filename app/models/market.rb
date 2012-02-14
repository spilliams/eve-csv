class Market

	def self.avg_sell(typeids,regionlimits)
		return nil unless typeids.count
		str = '?'
		str = "#{str}#{typeids.map {|typeid| "typeid=#{typeid}" }.join('&')}"
		str = "#{str}#{regionlimits.map {|limit| "&regionlimit=#{limit}" }.join("")}"
		doc = call(str)
		avg_sell_prices = {}

	end
private
	def self.call(path)
		url = "http://api.eve-central.com/api/marketstat#{path}"
		Nokogiri::XML(open(url))
	end

end