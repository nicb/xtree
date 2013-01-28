#
# $Id$
#
require 'optparse'
require File.expand_path(File.join(File.dirname(__FILE__), 'xtree'))

module Xtree
  class CLI
    def self.execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :archive_name     => 'xml_archive',
      }
      mandatory_options = %w( )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          xtree - print a directory tree similar to the tree command, but in xml (and csv).

          Usage: #{::File.basename($0)} [options] [<path>]

          The default path is '.' (dot -- the current directory).

          Options are:
        BANNER
        opts.separator ""
        opts.on("-a NAME", "--archive_name NAME", String,
                "Use this name as archive name",
                "Default: #{options[:archive_name]}") { |arg| options[:archive_name] = arg }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      archive_name = options[:archive_name]
      start_path = arguments[0] ? arguments[0] : '.'

      xt = Xtree.new(start_path, archive_name)
			a  = xt.generate
			xml_filename = archive_name =~ /\.xml\Z/i ? archive_name : archive_name + '.xml'
			File.open(xml_filename, 'w') { |fh| fh.puts(a) }

			true # to have test assertions succeed
    end
  end
end
