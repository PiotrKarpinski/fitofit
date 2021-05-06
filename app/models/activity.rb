class Activity < ApplicationRecord
  require 'geocoder'
  attr_accessor :starting_address, :end_address
  before_save :set_distance

  private
  def set_distance
    start_coords = coordinates(starting_address)
    end_coords = coordinates(end_address)
    self.distance = calculate_distance(start_coords, end_coords)
  end

  def calculate_distance(point_1, point_2)
    Geocoder::Calculations.distance_between(point_1, point_2)
  end

  def coordinates(address)
    Geocoder.coordinates(address)
  end
end
