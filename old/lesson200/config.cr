#
# config.cr
#
# copyright 2007-2022, ICUBIC
# author : W.F.F. Neimeijer
#

require "./poscolor.cr"

module GLM
  class Config

    property width  : Int32   = 640
    property height : Int32   = 800
    property title  : String  = ""
    property fov    : Float64 = 0.0
    property near   : Float64 = 1000.0
    property far    : Float64 = 0.1

    # 17-08-2023 not used # background color
    # 17-08-2023 not used property red    : Int32   = 128
    # 17-08-2023 not used property green  : Int32   = 128
    # 17-08-2023 not used property blue   : Int32   = 128
    # 17-08-2023 not used property alpha  : Float64 = 1.0

    # cameras
    property cameras : Array(PosColor)

    # lights
    property lights : Array(PosColor)

    # shaders
    property vertex_shader   : String = ""
    property fragment_shader : String = ""

    property vertex_source   : Array(String)
    property fragment_source : Array(String)

    property errors          : Array(String)

    #
    # nr seconds to run raymarcher
    # primary used in test spec
    #
    property runtime         : Int32 = 60 * 60

    def initialize
      @cameras         = [] of GLM::PosColor
      @lights          = [] of GLM::PosColor
      @errors          = [] of String
      @vertex_source   = [] of String
      @fragment_source = [] of String
    end

    def initialize(title : String, width : Int32, height : Int32, fov : Float64, near : Float64, far : Float64, runtime : Int32 = 60 * 60)
      @cameras         = [] of GLM::PosColor
      @lights          = [] of GLM::PosColor
      @errors          = [] of String
      @vertex_source   = [] of String
      @fragment_source = [] of String

      @title   = title
      @width   = width
      @height  = height
      @fov     = fov
      @near    = near
      @far     = far
      @runtime = runtime
    end

    # 17-08-2023, not used def set_background_color(red : Int32, green : Int32, blue : Int32, alpha : Float64)
    # 17-08-2023, not used   @red   = red
    # 17-08-2023, not used   @green = green
    # 17-08-2023, not used   @blue  = blue
    # 17-08-2023, not used   @alpha = alpha
    # 17-08-2023, not used end

    def set_cameras(index : Int32, x : Float64, y : Float64, z : Float64)
      begin
        @cameras[index] = GLM::PosColor.new(x,y,z)
      rescue e
        cam = GLM::PosColor.new(x,y,z)
        @cameras << cam
      end
    end

    def set_cameras(index : Int32, pos : ASY::Triple)
      begin
        @cameras[index] = GLM::PosColor.new(pos.x,pos.y,pos.z)
      rescue e
        lv_camera = GLM::PosColor.new(pos.x,pos.y,pos.z)
        @cameras << lv_camera
      end
    end

    def set_lights(index : Int32, x : Float64, y : Float64, z : Float64, red : Int32, green : Int32, blue : Int32, alpha : Float64)
      begin
        @lights[index] = GLM::PosColor.new(x,y,z, red, green, blue, alpha)
      rescue e
        light = GLM::PosColor.new(x,y,z,red,green,blue,alpha)
        @lights << light
      end
    end

    def set_lights(index : Int32, pos : ASY::Triple, red : Int32, green : Int32, blue : Int32, alpha : Float64)
      begin
        @lights[index] = GLM::PosColor.new(pos.x,pos.y,pos.z, red, green, blue, alpha)
      rescue e
        lv_light = GLM::PosColor.new(pos.x,pos.y,pos.z,red,green,blue,alpha)
        @lights << lv_light
      end
    end

    def set_vertex_shader(filename : String)
      @vertex_shader = filename
    end

    def set_fragment_shader(filename : String)
      @fragment_shader = filename
    end

    def check() : Bool

      if @width < 0
        @errors << "width of screen should be positive"
      end

      if @height < 0
        @errors << "height of screen should be positive"
      end

      if @cameras.size == 0
        @errors << "no cameras found"
      end

      if @lights.size == 0
        @errors << "no light sources found"
      end

      filename = @vertex_shader
      if filename == ""
        @errors << "no vertex shader specified"
      else
        if File.exists?(filename) == false
          @errors << "vertex shader '#{filename}' not found"
        end
      end

      filename = @fragment_shader
      if filename == ""
        @errors << "no fragment shader specified"
      else
        if File.exists?(filename) == false
          @errors << "fragment shader '#{filename}' not found"
        end
      end

      if @errors.size > 0
        return false
      end
      return true
    end
  end
end
