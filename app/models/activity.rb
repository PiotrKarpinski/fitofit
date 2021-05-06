class Activity < ApplicationRecord
  require 'geocoder'
  attr_accessor :starting_address, :end_address
  validates_presence_of :starting_address, :end_address
  before_save :set_distance

  def self.group_by_day
    Activity.where(created_at: get_week_range).group_by { |x| x.created_at.to_date }
  end

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

  def self.get_week_range
    Date.today.at_beginning_of_week.beginning_of_day..Date.today.at_end_of_week.end_of_day
  end
end
