#
# triple.cr
#
# copyright 2007-2022, ICUBIC
# author : W.F.F. Neimeijer
#

#
# All colors range from [0,255]
#
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
end
