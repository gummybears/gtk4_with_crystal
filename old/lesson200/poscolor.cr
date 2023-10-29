#
# poscolor.cr
#
# copyright 2007-2022, ICUBIC
# author : W.F.F. Neimeijer
#

#
# All colors range from [0,255]
#
require "./triple.cr"

module GLM

  class Triple
    property x : Float64 = 0.0
    property y : Float64 = 0.0
    property z : Float64 = 0.0

    def initialize(x : Int32,y : Int32, z : Int32)
      @x = 1.0 * x
      @y = 1.0 * y
      @z = 1.0 * z
    end

    def initialize(x : Float64,y : Float64, z : Float64)
      @x = x
      @y = y
      @z = z
    end
  end

  class PosColor
    property position : GLM::Triple = GLM::Triple.new(0,0,0)
    property red      : Int32   = 128
    property green    : Int32   = 128
    property blue     : Int32   = 128
    property alpha    : Float64 = 1.0

    def initialize
    end

    def initialize(x : Float64, y : Float64, z : Float64)
      @position = GLM::Triple.new(x,y,z)
    end

    def initialize(x : Float64, y : Float64, z : Float64, red : Int32, green : Int32, blue : Int32, alpha : Float64)
      @position = GLM::Triple.new(x,y,z)
      @red      = red
      @green    = green
      @blue     = blue
      @alpha    = alpha
    end
  end
end
