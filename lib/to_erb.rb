require "to_erb/version"
require "to_erb/erb_engine"

module ToErb
  def self.convert(infile,outfile)


    hamlcode = File.open(infile).read
    engine = ErbEngine.new(hamlcode)
    File.open(outfile,"w") do |file|
      file.write engine.render
    end

    print "converted #{infile} to #{outfile}\n"
  rescue Exception => e
    print "FAILED conersion of #{infile} due error #{e}"
  end
end
