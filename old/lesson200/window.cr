#
# window.cr
#
# copyright 2007-2022, ICUBIC
# author : W.F.F. Neimeijer
#
require "gtk4"
require "lib_gl"
require "stumpy_png"
require "./triple.cr"
require "./program.cr"
require "./model.cr"
require "./color.cr"
require "./config.cr"

#include StumpyPNG

module GLM
  class Window
    property app             : Gtk::Application
    #property window          : Gtk::ApplicationWindow
    property program         : Program
    property title           : String
    property width           : Int32
    property height          : Int32

    # shaders
    property vertex_shader   : String = ""
    property fragment_shader : String = ""

    # camera
    property camera          : GLM::Triple = GLM::Triple.new(0,0,0)

    # lights
    property lights          : Array(GLM::Triple)
    property primary_light   : GLM::Triple
    property errors          : Array(String)

    property runtime         : Int32 = 60 * 60

    def initialize(config : Config)

      config.check()
      @errors = config.errors

      if @errors.size > 0
        puts "The following errors were found"
        @errors.each do |e|
          puts "*) #{e}"
        end
        exit(-1)
      end

      @vertex_shader   = config.vertex_shader
      @fragment_shader = config.fragment_shader
      @title           = config.title
      @width           = config.width
      @height          = config.height
      @camera          = config.cameras[0].position
      @runtime         = config.runtime

      @lights = [] of GLM::Triple
      config.lights.each do |light|
        @lights << light.position
      end
      @primary_light = config.lights[0].position


      #
      # create a new window
      #
      @app = Gtk::Application.new("x.com", Gio::ApplicationFlags::None)
      @program = Program.new()

    end

    def run()

      @app.activate_signal.connect do

        window = Gtk::ApplicationWindow.new(@app)
        window.title = @title
        window.set_default_size(@width,@height)

        widget = Gtk::GLArea.new
        widget.auto_render = true
        widget.render_signal.connect do
          render(window,@width,@height)
        end

        window.child = widget
        window.present
      end
    end

    def render(window,w,h)
      #
      # load the quad and create the shader program
      #
      lv_model = Model.load_quad()

      # compile vertex and fragment shaders
      # must be done in run loop
      #
      @program.compile(@vertex_shader,@fragment_shader)

      #
      # Important to set viewport especially
      # when we resize the window
      #
      LibGL.viewport(0,0,w,h) #@width,@height)

      @program.use do

        @program.set_uniform_int("screen_width",      w) #@width)
        @program.set_uniform_int("screen_height",     h) #@height)
        #@program.set_uniform_float("time",            last_time.to_f32)
        @program.set_uniform_vector3("camera",        GLM::Vector3.new(@camera.x,@camera.y,@camera.z))
        @program.set_uniform_vector3("primary_light", GLM::Vector3.new(@primary_light.x,@primary_light.y,@primary_light.z))

        #
        # draw a model
        #
        lv_model.draw()
      end

      return true
    end

    #def run()
    #
    #  connect()
    #
    #  #
    #  # load the quad and create the shader program
    #  #
    #  lv_model = Model.load_quad()
    #
    #  # compile vertex and fragment shaders
    #  # must be done in run loop
    #  #
    #  @program.compile(@vertex_shader,@fragment_shader)
    #
    #  #
    #  # Important to set viewport especially
    #  # when we resize the window
    #  #
    #  LibGL.viewport(0,0,@width,@height)
    #
    #  @program.use do
    #
    #    @program.set_uniform_int("screen_width",      @width)
    #    @program.set_uniform_int("screen_height",     @height)
    #    #@program.set_uniform_float("time",            last_time.to_f32)
    #    @program.set_uniform_vector3("camera",        GLM::Vector3.new(@camera.x,@camera.y,@camera.z))
    #    @program.set_uniform_vector3("primary_light", GLM::Vector3.new(@primary_light.x,@primary_light.y,@primary_light.z))
    #
    #    #
    #    # draw a model
    #    #
    #    lv_model.draw()
    #  end
    #end
  end
end
