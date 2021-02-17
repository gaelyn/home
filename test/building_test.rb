require 'minitest/autorun'
require 'minitest/pride'
require './lib/building'
require './lib/apartment'
require './lib/renter'

class BuildingTest < Minitest::Test
  def test_it_exists
    building = Building.new
    assert_instance_of Building, building
  end

  def test_units_starts_as_empty_array
    building = Building.new
    assert_equal building.units, []
  end

  def test_it_can_units
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)

    assert_equal building.units, [unit1, unit2]
  end

  def test_renters_starts_as_empty_array
    building = Building.new

    assert_equal building.renters, []
  end

  def test_it_can_add_a_renter
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    building.add_unit(unit1)
    renter1 = Renter.new("Aurora")
    unit1.add_renter(renter1)

    assert_equal building.renters, ["Aurora"]
  end

  def test_it_can_add_another_renter
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)
    renter1 = Renter.new("Aurora")
    renter2 = Renter.new("Tim")
    unit1.add_renter(renter1)
    unit2.add_renter(renter2)

    assert_equal building.renters, ["Aurora", "Tim"]
  end

  def test_finding_building_average_rent
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)

    assert_equal building.average_rent, 1099.5
  end

  def test_it_starts_with_no_rented_units
    building = Building.new

    assert_equal building.rented_units, []
  end

  def test_it_can_add_rented_units
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    unit2.add_renter(renter1)

    assert_equal building.rented_units, [unit2]
  end

  def test_it_can_find_unit_with_highest_rent
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    unit2.add_renter(renter1)

    assert_equal building.renter_with_highest_rent, renter1

    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)

    assert_equal building.renter_with_highest_rent, renter2

    renter3 = Renter.new("Max")
    unit3.add_renter(renter3)

    assert_equal building.renter_with_highest_rent, renter2
  end
end
