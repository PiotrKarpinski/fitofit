module ActivitiesHelper
  def format_distance(number)
    "#{number}km"
  end

  def format_date(date)
    date.strftime("%e\. %B")
  end

end
