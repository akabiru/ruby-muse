module Concerns::Findable
	def find_by_name name
		@@all.select { |song| song.name == name }.first
	end

	def find_or_create_by_name name
		result = find_by_name name
		result = create name unless result
		result
	end
end