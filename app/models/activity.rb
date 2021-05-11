class Activity < ApplicationRecord
  require 'geocoder'

  validates_presence_of :starting_street,
                        :starting_city,
                        :starting_country, :end_street,
                        :end_city,
                        :end_country
  validate :valid_address, on: %i[create update]

  before_save :set_distance
  def self.group_by_day
    Activity.where(created_at: get_week_range).order(created_at: :desc).group_by { |x| x.created_at.to_date }
  end

  private


  def set_distance
    starting_address = "#{starting_street}, #{starting_city}, #{starting_country}"
    end_address = "#{end_street}, #{end_city}, #{end_country}"

    start_coords = coordinates(starting_address)
    end_coords = coordinates(end_address)
    self.distance = calculate_distance(start_coords, end_coords)

  end

  def calculate_distance(point_1, point_2)
    Geocoder::Calculations.distance_between(point_1, point_2)
  end

  def valid_address
    starting_address = "#{starting_street}, #{starting_city}, #{starting_country}"
    end_address = "#{end_street}, #{end_city}, #{end_country}"

    if !coordinates(starting_address) || !coordinates(end_address)
      errors.add(:base, "Could not find address, please enter valid address")
    end
  end

  def coordinates(address)
    Geocoder.coordinates(address)
  end

  def self.get_week_range
    Date.today.at_beginning_of_week.beginning_of_day..Date.today.at_end_of_week.end_of_day
  end
end
