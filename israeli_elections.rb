require "json"

module IsraeliElections 
	
	class Party
		attr_accessor :name
		attr_accessor :votes
		attr_accessor :seats
	
		def initialize(name)
			@name = name	
			@votes = 0
			@seats = 0
		end
	
		def add_votes(votes)
			@votes += votes
		end
	
		def set_votes(votes)
			@votes = votes	
		end
	
		def to_s
			return "#{@name}: (#{@votes}, #{@seats})"
		end
	end

	class SuprplusAgreement
		attr_accessor :parties
	
		def initialize(party, other_party)
			@parties = [party, other_party]
		end
	
		def to_s
			return "#{@parties}"
		end
	
	end
	
	class ElectionResults
		attr_accessor :parties
	
		def initialize(threshhold_percentage)
			@threshhold_percentage = threshhold_percentage
			@parties = []
			@surplus_agreements = []		
		end
	
		def add_party(party)
			@parties << party
		end
	
		def add_surplus_agreement(surplus_agreement)
			@surplus_agreements << surplus_agreement
		end
	
		def print_results
			puts @parties.sort {|p1, p2| -p1.votes <=> -p2.votes}
			puts "---\nthreshold: #{@threshold}"
		end
	
		def calc_seats
			calc_total_votes()
			calc_threshold()
	
			passed = {} # key is party.name, value is party object
	
			@parties.each do |party| 
				if (party.votes > @threshold) 
					passed[party.name] = party
				end
			end
	
			total_pased_votes = passed.values.inject(0){ |sum, party| sum += party.votes }
			seat_index = (total_pased_votes / 120).floor
	
			passed.values.each do |party|
				party.seats = (party.votes / seat_index).floor 
			end
						
			occupied_seats = passed.values.inject(0) { |sum, party| sum += party.seats }
	
			surplus_agreements_map = {}
			@surplus_agreements.each do |sa| 
				party = sa.parties[0]
				other_party = sa.parties[1]
	
				# save in map only if both parties passed threshold
				if (!passed[party.name].nil? and !passed[other_party.name].nil?) 
					surplus_agreements_map[party.name] = other_party
					surplus_agreements_map[other_party.name] = party
				end
			end
	
			while (occupied_seats < 120) do
				
				new_seat_index = {}	# key is party.name, value is the new seat_index for this party assuming it gets another mandate
				passed.each do |k, party|
					new_seat_index[k] = party.votes / (party.seats + 1)	
	
					if (!surplus_agreements_map[k].nil?)
						other_party = surplus_agreements_map[k]
						new_seat_index[party.name] = new_seat_index[other_party.name] = (party.votes + other_party.votes) / (party.seats + other_party.seats + 1)
					end
	
				end
	
				# find the party with the largest new seat-index
				largest_new_seat_index = 0
				largest_seat_index_party = nil
				new_seat_index.each do |k, m|
					if (m > largest_new_seat_index)
						largest_new_seat_index = m
						largest_seat_index_party = passed[k]
					end
				end
	
				# if the party with largest new seat-index has a surplus agreement,
				# we need to check which of the 2 parties will get the extra seat
				if (surplus_agreements_map[largest_seat_index_party.name])
					party = largest_seat_index_party
					other_party = surplus_agreements_map[largest_seat_index_party.name]
	
					new_seat_index_for_party = party.votes / (party.seats + 1)
					new_seat_index_for_other_party = other_party.votes / (other_party.seats + 1)
					largest_seat_index_party = new_seat_index_for_party > new_seat_index_for_other_party ? party : other_party
				end
	
				largest_seat_index_party.seats += 1
	
				occupied_seats += 1
			end	
		end
	
		private
		def calc_total_votes
			@total_votes = @parties.inject(0){ |sum, party| sum += party.votes }
		end
	
		def calc_threshold
			@threshold = @total_votes * @threshhold_percentage / 100
			@threshold = @threshold.floor
		end
	
	end


	def IsraeliElections.build_election_result_from_file(file_name)
		elections_json_text = File.read(file_name)
		elections_json = JSON.parse(elections_json_text)
	
		votes = elections_json["votes"]
		surplus_agreement_map = elections_json["surplus_agreement"]
		threshhold_percentage = elections_json["threshhold_percentage"]
	
		parties = []
		votes.each do |name, votes|
			party = Party.new(name)
			party.set_votes(votes)
			parties << party
		end
	
		suprplus_agreements = []
		surplus_agreement_map.each do |party_name, other_party_name|
	
			party = parties[parties.find_index { |x| x.name == party_name}]
			other_party = parties[parties.find_index { |x| x.name == other_party_name}]
	
			agreement = SuprplusAgreement.new(party, other_party)
			suprplus_agreements << agreement
	
		end	
	
		election_result = ElectionResults.new(threshhold_percentage)
		parties.each { |p| election_result.add_party(p) }
		suprplus_agreements.each { |a| election_result.add_surplus_agreement(a) }
	
		return election_result
	end

end




if ARGV.length == 1
	election_result = IsraeliElections::build_election_result_from_file(ARGV[0])
	election_result.calc_seats()
	election_result.print_results()
end
