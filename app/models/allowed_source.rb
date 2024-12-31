class AllowedSource < ApplicationRecord
	validates :octet1. :octet2. :octet3. :octet4. presence: true,
	numericality: { only_integer: true, allow_blank: true },
	inclusion: { in: 0..255, allow_blank: true }
	validates :octet4,
	uniqueness: {
		scope: [ :namespace, :octet1, :octet2, :octet3], allow_blank: true
	}
	def ip_adress=(ip_address)
		octets = ip_address.split(".")
		self.octet1 = octets[0]
		self.octet2 = octets[1]
		self.octet3 = octets[2]
		
		if octets[3] == "*"
			self.octet4 = 0
			self.wildcard = true
		else
			self.octet4 = octets[3]
		end
	end
end
