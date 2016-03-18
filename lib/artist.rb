class Artist
	attr_accessor :name
	@@all = []

	def initialize name
		@name = name
	end

	def self.all
		@@all
	end

	def self.destroy_all
		@@all = []
	end

	def save
		@@all.push self
		self
	end

	def self.create name
		Artist.new(name).save
	end

end