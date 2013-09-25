class EventFactory
  def create date, time, name, link, type
    starting_hour, ending_hour = time.split(" till ")
    starting_date_time = DateTime.parse("#{date.to_s} #{starting_hour} +5:30")
    ending_date_time = DateTime.parse("#{date.to_s} #{ending_hour} +5:30")
    
    Event.new(starting_date_time, ending_date_time, name, link, type)
  end
end