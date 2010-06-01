module Puppet::Parser::Functions

  # Returns the directory part of one or an array of paths.
  newfunction(:dirname, :type => :rvalue) do |args|
    if args[0].is_a?(Array)
      args.collect do |a| File.dirname(a) end
    else
      File.dirname(args[0])
    end
  end

end
