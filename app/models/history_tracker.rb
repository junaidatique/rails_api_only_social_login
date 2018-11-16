class HistoryTracker
  include Mongoid::Document
  include Mongoid::History::Tracker
end
