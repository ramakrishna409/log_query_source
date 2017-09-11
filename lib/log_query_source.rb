require 'active_record/log_subscriber'

module LogQuerySource

  class << self
    attr_accessor :lines
    attr_accessor :level
  end

  def debug(*args, &block)    
    return unless super
    backtrace = clean_trace(caller)[0..LogQuerySource.lines-1]
    logger.debug("  |\n  ↳ #{backtrace.join(" \n")} \n")  if backtrace  
  end

  def clean_trace trace
    backtrace = case LogQuerySource.level
    when :full
      trace
    when :rails
      Rails.respond_to?(:backtrace_cleaner) ? Rails.backtrace_cleaner.clean(trace) : trace
    when :app
      Rails.backtrace_cleaner.remove_silencers!
      Rails.backtrace_cleaner.add_silencer { |line| not line =~ /^(app|lib|engines)\// }
      Rails.backtrace_cleaner.clean(trace)
    else
      raise "Invalid ALogQuerySource.level value '#{LogQuerySource.level}' - should be :full, :rails, or :app"
    end
  end

end
ActiveRecord::LogSubscriber.send :prepend, LogQuerySource