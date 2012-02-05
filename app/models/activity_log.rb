class ActivityLog < ActiveRecord::Base

	validates_presence_of :ip_address, :activity

	def self.log( params )
		new( params ).save
	end

end
