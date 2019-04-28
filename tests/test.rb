require 'test/unit'
require './israeli_elections.rb'

class Test2013 < Test::Unit::TestCase
  def setup
		election_result = IsraeliElections::build_election_result_from_file("data/elections_2013.json")
		election_result.calc_seats()
		@parties = {}
		election_result.parties.each { |p| @parties[p.name] = p}
  end

  def teardown
  end

  def test_2013
		assert(@parties["likud_liberman"].seats == 31, 'failed to calc likud_liberman mandates')
		assert(@parties["haavoda"].seats == 15, 'failed to calc haavoda mandates')
		assert(@parties["yesh_atid"].seats == 19, 'failed to calc yesh_atid mandates')
		assert(@parties["hatnuha"].seats == 6, 'failed to calc hatnuha mandates')
		assert(@parties["jew_home"].seats == 12, 'failed to calc jew_home mandates')
		assert(@parties["shas"].seats == 11, 'failed to calc shas mandates')
		assert(@parties["hatora"].seats == 7, 'failed to calc hatora mandates')
		assert(@parties["meretz"].seats == 6, 'failed to calc meretz mandates')
		assert(@parties["raam_taal"].seats == 4, 'failed to calc raam_taal mandates')
		assert(@parties["hadash"].seats == 4, 'failed to calc hadash mandates')
		assert(@parties["balad"].seats == 3, 'failed to calc balad mandates')
		assert(@parties["kadima"].seats == 2, 'failed to calc kadima mandates')
  end
end

class Test2015 < Test::Unit::TestCase
  def setup
		election_result = IsraeliElections::build_election_result_from_file("data/elections_2015.json")
		election_result.calc_seats()
		@parties = {}
		election_result.parties.each { |p| @parties[p.name] = p}
  end

  def teardown
  end

  def test_2015
		assert(@parties["likud"].seats == 30, 'failed to calc likud_liberman mandates')
		assert(@parties["haavoda"].seats == 24, 'failed to calc haavoda mandates')
		assert(@parties["arabs_joined_party"].seats == 13, 'failed to calc arabs_joined_party mandates')
		assert(@parties["yesh_atid"].seats == 11, 'failed to calc yesh_atid mandates')
		assert(@parties["kulanu"].seats == 10, 'failed to calc kulanu mandates')
		assert(@parties["shas"].seats == 7, 'failed to calc shas mandates')
		assert(@parties["hatora"].seats == 6, 'failed to calc hatora mandates')
		assert(@parties["meretz"].seats == 5, 'failed to calc meretz mandates')		
		assert(@parties["jew_home"].seats == 8, 'failed to calc jew_home mandates')
		assert(@parties["liberman"].seats == 6, 'failed to calc liberman mandates')
		assert(@parties["eli_ishay"].seats == 0, 'failed to calc eli_ishay mandates')
		assert(@parties["ale_yarok"].seats == 0, 'failed to calc ale_yarok mandates')
  end
end


class Test2019 < Test::Unit::TestCase
  def setup
		election_result = IsraeliElections::build_election_result_from_file("data/elections_2019.json")
		election_result.calc_seats()
		@parties = {}
		election_result.parties.each { |p| @parties[p.name] = p}
  end

  def teardown
  end

  def test_2019
		assert(@parties["likud"].seats == 35, 'failed to calc likud mandates')
		assert(@parties["haavoda"].seats == 6, 'failed to calc haavoda mandates')
		assert(@parties["kahol_lavan"].seats == 35, 'failed to calc kahol_laval mandates')
		assert(@parties["kulanu"].seats == 4, 'failed to calc kulanu mandates')
		assert(@parties["shas"].seats == 8, 'failed to calc shas mandates')
		assert(@parties["hatora"].seats == 8, 'failed to calc hatora mandates')
		assert(@parties["meretz"].seats == 4, 'failed to calc meretz mandates')		
		assert(@parties["jew_home"].seats == 5, 'failed to calc jew_home mandates')
		assert(@parties["liberman"].seats == 5, 'failed to calc liberman mandates')
		assert(@parties["hadassh"].seats == 6, 'failed to calc hadassh mandates')
		assert(@parties["balad"].seats == 4, 'failed to calc balad mandates')
  end
end

class Test2019NotFinal < Test::Unit::TestCase
  def setup
		election_result = IsraeliElections::build_election_result_from_file("data/elections_2019_not_final.json")
		election_result.calc_seats()
		@parties = {}
		election_result.parties.each { |p| @parties[p.name] = p}
  end

  def teardown
  end

  def test_2019_not_final
		assert(@parties["likud"].seats == 36, 'failed to calc likud mandates')
		assert(@parties["haavoda"].seats == 6, 'failed to calc haavoda mandates')
		assert(@parties["kahol_lavan"].seats == 35, 'failed to calc kahol_laval mandates')
		assert(@parties["kulanu"].seats == 4, 'failed to calc kulanu mandates')
		assert(@parties["shas"].seats == 8, 'failed to calc shas mandates')
		assert(@parties["hatora"].seats == 7, 'failed to calc hatora mandates')
		assert(@parties["meretz"].seats == 4, 'failed to calc meretz mandates')		
		assert(@parties["jew_home"].seats == 5, 'failed to calc jew_home mandates')
		assert(@parties["liberman"].seats == 5, 'failed to calc liberman mandates')
		assert(@parties["hadassh"].seats == 6, 'failed to calc hadassh mandates')
		assert(@parties["balad"].seats == 4, 'failed to calc balad mandates')
  end
end