#
# preprocess.cr
#
# copyright 2007-2022, ICUBIC
# author : W.F.F. Neimeijer
#

#
# a very simple preprocessor
# to break up large OpenGL code
# into smaller modules
#
module GLM

  class Preprocess

    property lines      : Array(String)
    property errors     : Array(String)
    property includedir : String = ""

    def initialize()
      @lines  = [] of String
      @errors = [] of String
    end

    #
    # valid filenames
    # lowercase
    # uppercase
    # optional dot (could be more than 1)
    # optional numbers
    # optional directory separator
    #
    def get_include_file(line : String) : {Bool, String}

      lv_match = line.match(/include\s([a-z|A-Z|_|\.|[0-9|\/]+)/)
      if lv_match
        lv_match = lv_match.not_nil!
        if lv_match.size == 2

          #
          # need to find OpenGL include file
          # relative to location of main file
          #
          lv_find_file = @includedir + "/" + lv_match[1]
          if File.exists?(lv_find_file) == false
            @errors << "file '#{lv_match[1]}' not found"
            return false, ""
          end
          lv_include_file = File.realpath(lv_find_file)
          return true, lv_find_file

          # 28-08-2023 old code if File.exists?(lv_match[1]) == false
          # 28-08-2023 old code   @errors << "file '#{lv_match[1]}' not found"
          # 28-08-2023 old code   return false, ""
          # 28-08-2023 old code end
          # 28-08-2023 old code lv_include_file = File.realpath(lv_match[1])
          # 28-08-2033 return true, lv_match[1]
        end
      end

      return false, ""
    end

    def read(filename : String, lines : Array(String))

      lines.each do |line|

        lv_found, lv_include_file = get_include_file(line)
        if lv_found

          if filename == lv_include_file
            @errors << "include file '#{lv_include_file}' circular referenced in #{filename}"
            return
          end

          lv_pre = Preprocess.new()
          #
          # copy the value of includedir
          #
          lv_pre.includedir = @includedir

          lv_pre.read(lv_include_file)
          lv_include_lines = lv_pre.lines
          lv_include_lines.each do |x|
            @lines << x if x.size > 0
          end
        else
          @lines << line
        end # if
      end # each
    end

    def read(filename : String)
      lv_lines = File.read_lines(filename)
      read(filename,lv_lines)
    end # read
  end
end

