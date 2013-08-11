# ruby 1.8.7 compatible
require 'rubygems'
require 'irb/completion'

# interactive editor: use vim from within irb
begin
  require 'interactive_editor'
rescue LoadError => err
  warn "Couldn't load interactive_editor: #{err}"
end

# awesome print
begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError => err
  warn "Couldn't load awesome_print: #{err}"
rescue Exception => err
  warn "Couldn't load awesome_print: #{err}"
end

begin
  require 'wirble'
  Wirble.init
  # Comment out line below to suppress console result coloring
  Wirble.colorize unless Config::CONFIG['host_os'] == 'mswin32'
rescue LoadError => err
  warn "Couldn't load wirble: #{err}"
  # Wirble gem not installed
  # load rubygems & pp.  Normally done by wirble
  require 'pp'
end

begin

  IRB.conf[:PROMPT_MODE] = :SIMPLE
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

  IRB.conf[:SAVE_HISTORY] = 10000
  IRB.conf[:EVAL_HISTORY] = 10000
  ENV['IRB_HISTORY_FILE'] = "#{ENV['HOME']}/.irb_history"
  # Uncomment line below to have seperate irb history from rails script/console
  #IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history_rails" if ENV['RAILS_ENV']
  IRB.conf[:AUTO_INDENT] = true

  require 'rbconfig' rescue nil
  require 'win32/console/ansi' if RbConfig::CONFIG['host_os'] == 'mswin32'


  # Clear
  def cls
    Config::CONFIG['host_os'] == 'mswin32' ? system('cls') : system('clear')
  end


  # Textmate helper
  def mate *args
    flattened_args = args.map {|arg| "\"#{arg.to_s}\""}.join ' '
    `mate #{flattened_args}`
    nil
  end

  # Gedit helper
  def gedit *args
    flattened_args = args.map { |arg| "\"#{arg.to_s}\""}.join ' '
    `gedit #{flattened_args}`
    nil
  end

  class Object
    def local_methods
      case self.class
      when Class
        self.public_methods.sort - Object.public_methods
      when Module
        self.public_methods.sort - Module.public_methods
      else
        self.public_methods.sort - Object.new.public_methods
      end
    end
  end

  # show_regexp - stolen from the pickaxe
  def show_regexp(a, re)
     if a =~ re
        "#{$`}<<#{$&}>>#{$'}"
     else
        "no match"
     end
  end

  # Convenience method on Regexp so you can do
  # /an/.show_match("banana")
  class Regexp
     def show_match(a)
         show_regexp(a, self)
     end
  end

  alias q exit
  alias quit exit

  def show_log
    app.get('/') if defined?(app)
    set_logger_to Logger.new(STDOUT)
  end

  def hide_log
    set_logger_to RAILS_DEFAULT_LOGGER
  end

  def set_logger_to(logger)
    logger.flush if logger.respond_to?(:flush)
    ActiveRecord::Base.logger = logger
    ActionController::Base.logger = logger
    ActiveRecord::Base.clear_active_connections!
  end

  puts '.irbrc loaded'
rescue => e
  puts e.message
  puts e.backtrace
  puts 'ERROR loading .irbrc'
end
