class Event

  attr_reader :starting_time, :ending_time, :name, :session_link, :type

  def initialize(starting_time, ending_time, name, session_link, type, week, day_of_the_week) 
    @starting_time = starting_time
    @ending_time = ending_time
    @name = name
    @session_link = session_link
    @type = type.to_sym
    @week = week
    @day_of_the_week = day_of_the_week
  end

  def to_event_resource
    {
      'colorId' => SessionTypes.by_type(type).color_id,
      'start' =>  { 'dateTime' => starting_time.rfc3339 },
      'end' => { 'dateTime' => ending_time.rfc3339 },
      'description' => session_link,
      'summary' => name
    }
  end

  def to_json param
    {
      :name => @name,
      :session_link => @session_link,
      :type => @type.to_s,
      :week => @week,
      :day_of_the_week => @day_of_the_week
    }.to_json
  end

end

