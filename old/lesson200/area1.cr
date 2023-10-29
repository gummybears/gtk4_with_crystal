require "gtk4"
require "lib_gl"
require "./program.cr"
require "./config.cr"
require "./model.cr"

class Window < Gtk::GLArea

  property program : GLM::Program
  property model   : GLM::Model
  property config  : GLM::Config
  property time    : Float32 = 0

  def initialize(config)
    super()
    auto_render = true

    @config  = config
    @program = GLM::Program.new
    @model   = GLM::Model.load_quad()

    render_signal.connect do
      render
    end

    resize_signal.connect do
      @config.width  = width
      @config.height = height
    end

    frame_clock = Gdk::FrameClock.new
    add_tick_callback(->gtk_tick(self,frame_clock,false))
  end

  def gtk_tick(widget : Gtk::GLArea, frame_clock : Gdk::FrameClock, user_data : Bool) : Gtk::TickCallback
    #frame      = frame_clock.frame_counter
    #frame_time = frame_clock.frame_time
    ##return G_SOURCE_CONTINUE;
    #return true
    @time = @time + 1
    queue_draw
  end

  #def update_ticker : Gtk::TickCallback
  #  #frame_clock = Gdk::FrameClock.new(lib_frame_clock, GICrystal::Transfer::None)
  #  return Gtk::TickCallback.new(Proc(self, Gdk::FrameClock, Bool))
  #end

  def render : Bool

    @model = GLM::Model.load_quad()
    @program.compile(@config.vertex_shader,@config.fragment_shader)

    @program.use do

      LibGL.viewport(0,0,@config.width,@config.height)

      red_value   = 0
      green_value = 0
      blue_value  = 0

      # Clear the window with the generated color.
      LibGL.clear_color(red_value, green_value, blue_value, 1.0)
      LibGL.clear(LibGL::COLOR_BUFFER_BIT)

      @program.set_uniform_float("time",@time.to_f32)
      @program.set_uniform_int("screen_width",      @config.width)
      @program.set_uniform_int("screen_height",     @config.height)
      camera        = @config.cameras[0].position
      primary_light = @config.lights[0].position

      program.set_uniform_vector3("camera",        GLM::Vector3.new(camera.x,camera.y,camera.z))
      program.set_uniform_vector3("primary_light", GLM::Vector3.new(primary_light.x,primary_light.y,primary_light.z))

      #
      # draw a model
      #
      @model.draw()
    end

    return true
  end
end

seconds = 2
config = GLM::Config.new("Title (press the ESC key to exit OpenGL window)",640,640,70,0.1,1000,seconds)
config.set_cameras(0,0.0,3.0,-10.0)
config.set_lights(0,0.0,3.0,-1.0,255,255,255,1)
config.set_vertex_shader("main.vs")
config.set_fragment_shader("main1.fs")

app = Gtk::Application.new("hello.opengl.com", Gio::ApplicationFlags::None)

app.activate_signal.connect do

  window = Gtk::ApplicationWindow.new(app)
  window.title = "Gtk GLArea"
  window.set_default_size(config.width,config.height)


  widget = Window.new(config)
  window.child = widget
  window.present
end

exit(app.run)
