require 'google/api_client'

class GoogleCalendar

    def initialize(auth_code)
      @client = Google::APIClient.new

      @client.authorization.client_id = ENV['TWU_CALENDAR_OAUTH2_CLIENT_ID']
      @client.authorization.client_secret = ENV['TWU_CALENDAR_OAUTH2_CLIENT_SECRET']
      @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
      @client.authorization.redirect_uri = 'http://localhost:9393/google_register_permissions'

      @client.authorization.code = auth_code
      @client.authorization.fetch_access_token!

      @calendar_api = @client.discovered_api('calendar', 'v3')
    end

    def create_calendar calendar_name
      result = nil
      begin
      ensure_authorized {
        result = @client.execute(:api_method => @calendar_api.calendars.insert,
                                 :body =>  { 'summary' => calendar_name }.to_json,
                                 :headers => {'Content-Type' => 'application/json'})
      }
      rescue Exception => e
        debugger
        puts e
      end
      result.data.id
    end

    def create_events events, calendar_id
      events.each do |event|
        puts "Creating event #{event.to_event_resource.inspect}"
        ensure_authorized {
          result = @client.execute(:api_method => @calendar_api.events.insert,
                          :parameters => { 'calendarId' => calendar_id },
                          :body => event.to_event_resource.to_json,
                          :headers => {'Content-Type' => 'application/json'})
        }
      end
    end

    private

    def ensure_authorized
      begin
        yield
        return
      rescue Exception => e
        puts e
        @client.authorization.fetch_access_token!
      end
    end

end

