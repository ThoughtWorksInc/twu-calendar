#!/usr/bin/env ruby

require_relative 'lib/twu_calendar'

events = parse_events
create_trello_board(events)
