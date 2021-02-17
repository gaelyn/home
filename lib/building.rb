class Building
  attr_reader :units,
              :rented_units
  def initialize
    @units = []
    @renters = renters
    @rented_units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    @units.map do |unit|
      unit.renter.name
    end
  end

  def average_rent
    @sum = @units.sum do |unit|
      unit.monthly_rent.to_f
    end
    @sum/@units.count
  end

  def rented_units
    @rented_units = units.find_all do |unit|
      unit.renter != nil
    end
  end

  def renter_with_highest_rent
    rented_units
    @highest_rent = @rented_units.max_by do |unit|
      unit.monthly_rent
    end
    @highest_rent.renter
  end
end
