#require "./config.cr"
require "./window.cr"

seconds = 2
config = GLM::Config.new("Title (press the ESC key to exit OpenGL window)",640,640,70,0.1,1000,seconds)

config.set_cameras(0,0.0,3.0,-10.0)
config.set_lights(0,0.0,3.0,-1.0,255,255,255,1)
config.set_vertex_shader("main.vs")
config.set_fragment_shader("main1.fs")

w = GLM::Window.new(config)
w.run()
