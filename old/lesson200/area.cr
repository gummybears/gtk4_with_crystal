require "gtk4"
require "lib_gl"
#require "lib_glfw"

require "./program.cr"
require "./config.cr"
require "./model.cr"

def render(program,config) : Bool

  lv_model = GLM::Model.load_quad()
  program.compile(config.vertex_shader,config.fragment_shader)

  program.use do

    LibGL.viewport(0,0,config.width,config.height)

    red_value   = 0
    green_value = 0
    blue_value  = 0

    # Clear the window with the generated color.
    LibGL.clear_color(red_value, green_value, blue_value, 1.0)
    LibGL.clear(LibGL::COLOR_BUFFER_BIT)

    # x = LibGLFW.get_time
    # program.set_uniform_float("time",x.to_f32)

    program.set_uniform_int("screen_width",      config.width)
    program.set_uniform_int("screen_height",     config.height)
    camera = config.cameras[0].position
    primary_light = config.lights[0].position

    program.set_uniform_vector3("camera",        GLM::Vector3.new(camera.x,camera.y,camera.z))
    program.set_uniform_vector3("primary_light", GLM::Vector3.new(primary_light.x,primary_light.y,primary_light.z))

    #
    # draw a model
    #
    lv_model.draw()
  end

  return true
end

program = GLM::Program.new()
seconds = 2
config = GLM::Config.new("Title (press the ESC key to exit OpenGL window)",640,640,70,0.1,1000,seconds)

config.set_cameras(0,0.0,3.0,-10.0)
config.set_lights(0,0.0,3.0,-1.0,255,255,255,1)
config.set_vertex_shader("main.vs")
config.set_fragment_shader("main1.fs")

app = Gtk::Application.new("hello.opengl.com", Gio::ApplicationFlags::None)

#widget = Gtk::GLArea.new

app.activate_signal.connect do

  window = Gtk::ApplicationWindow.new(app)
  window.title = "Gtk GLArea"
  window.set_default_size(config.width,config.height)

  widget = Gtk::GLArea.new
  widget.auto_render = true
  widget.render_signal.connect do
    render(program,config)
  end

  #
  # set the config width/height on widget resize
  #
  widget.resize_signal.connect do
    config.width = widget.width
    config.height = widget.height
  end

  #
  # need to update the timer and
  # propagate the new value to the fragment shader
  # variable "time"
  #
  #widget.add_tick_callback(callback) #,widget)

  window.child = widget
  window.present
end

#def callback : Gtk::TickCallback
#  puts "x"
#  lib_frame_clock = 0 #Pointer(Void).new
#  frame_clock = Gdk::FrameClock.new(lib_frame_clock, GICrystal::Transfer::None)
#  x = Gtk::TickCallback.new(widget,frame_clock,true)
#  return x
#end

exit(app.run)
