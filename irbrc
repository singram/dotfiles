begin

  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

  IRB.conf[:SAVE_HISTORY] = 10000
  ENV['IRB_HISTORY_FILE'] = "#{ENV['HOME']}/.irb_history"
  # Uncomment line below to have seperate irb history from rails script/console
  #IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history_rails" if ENV['RAILS_ENV']
  IRB.conf[:AUTO_INDENT] = true

  require 'rbconfig' rescue nil
  require 'win32/console/ansi' if Config::CONFIG['host_os'] == 'mswin32'

  begin
    require 'rubygems' rescue nil
    require 'wirble'
    Wirble.init
    # Comment out line below to suppress console result coloring
    Wirble.colorize unless Config::CONFIG['host_os'] == 'mswin32'
  rescue
    # Wirble gem not installed
    # load rubygems & pp.  Normally done by wirble
    require 'pp'
  end

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
      (methods - Object.instance_methods).sort
    end

    def local_methods2(obj = self)
      (obj.methods - obj.class.superclass.instance_methods).sort
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

  puts '.irbrc loaded'
rescue Exception => e
  puts e.message
  puts e.backtrace
  puts 'ERROR loading .irbrc'
end