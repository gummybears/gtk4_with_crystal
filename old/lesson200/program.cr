#
# program.cr
#
# copyright 2007-2022, ICUBIC
# author : W.F.F. Neimeijer
#
require "./preprocess.cr"
require "./math/glm.cr"

module GLM
  class Program

    property program_id : LibGL::UInt = 0
    property vs_id      : LibGL::UInt = 0
    property fs_id      : LibGL::UInt = 0

    def initialize()
    end

    def compile(vertex_source : Array(String), fragment_source : Array(String))

      lv_vertex_text   = vertex_source.join("\n")
      lv_fragment_text = fragment_source.join("\n")

      @vs_id = load_shader(lv_vertex_text, LibGL::VERTEX_SHADER)
      @fs_id = load_shader(lv_fragment_text, LibGL::FRAGMENT_SHADER)

      @program_id = LibGL.create_program()

      LibGL.attach_shader(@program_id, @vs_id)
      LibGL.attach_shader(@program_id, @fs_id)
      LibGL.link_program(@program_id)
      LibGL.validate_program(@program_id)

      LibGL.delete_shader(@vs_id)
      LibGL.delete_shader(@fs_id)
    end

    def compile(vertexfile : String, fragmentfile : String)

      if File.exists?(vertexfile) == false
        puts "opengl : file '#{vertexfile}' not found"
        return
      end

      if File.exists?(fragmentfile) == false
        puts "opengl : file '#{fragmentfile}' not found"
        return
      end

      lv_pre1 = GLM::Preprocess.new()
      lv_pre1.includedir = File.realpath(File.dirname(vertexfile))
      lv_pre1.read(vertexfile)
      lv_vertex_lines = lv_pre1.lines

      if lv_pre1.errors.size > 0
        puts "opengl : errors found during preprocessing of '#{vertexfile}'"
        lv_pre1.errors.each do |e|
          puts e
        end
        return
      end

      lv_pre2 = GLM::Preprocess.new()
      lv_pre2.includedir = File.realpath(File.dirname(fragmentfile))
      lv_pre2.read(fragmentfile)
      lv_fragment_lines = lv_pre2.lines

      if lv_pre2.errors.size > 0
        puts "opengl : errors found during preprocessing of '#{fragmentfile}'"
        lv_pre2.errors.each do |e|
          puts e
        end
        return
      end

      compile(lv_vertex_lines,lv_fragment_lines)
    end

    def use(&block)
      LibGL.use_program(@program_id)
      yield
    end

    def start()
      LibGL.use_program(@program_id)
    end

    def stop()
      LibGL.use_program(0)
    end

    def cleanup()
      stop()
      LibGL.detach_shader(@program_id, @vs_id)
      LibGL.detach_shader(@program_id, @fs_id)
      LibGL.delete_shader(@vs_id)
      LibGL.delete_shader(@fs_id)
      LibGL.delete_program(@program_id)
    end

    def bind_attribute(attribute : Int32, variable_name : String)
      LibGL.bind_attrib_location(@program_id, attribute, variable_name)
    end

    def load_shader(text : String, type : LibGL::UInt) : LibGL::UInt

      lv_shader_id = LibGL.create_shader(type)
      if lv_shader_id == 0
        lv_shader_error_code = LibGL.get_error

        lv_str = [] of String
        lv_str << "opengl : shader creation failed"
        lv_str << "#{lv_shader_error_code}"
        puts = lv_str.join("\n")
        exit
      end

      lv_ptr    = text.to_unsafe
      lv_source = [lv_ptr]

      LibGL.shader_source(lv_shader_id, 1, lv_source, Pointer(Int32).new(0))
      LibGL.compile_shader(lv_shader_id)

      LibGL.get_shader_iv(lv_shader_id, LibGL::COMPILE_STATUS, out lv_compile_status)

      if lv_compile_status == LibGL::FALSE
        # 30-08-2023 old code LibGL.get_shader_info_log(lv_shader_id, 2048, nil, out lv_compile_log)
        LibGL.get_shader_info_log(lv_shader_id, 2*2048, nil, out lv_compile_log)

        lv_compile_log_str    = String.new(pointerof(lv_compile_log))
        lv_compile_error_code = LibGL.get_error

        lv_str = [] of String
        lv_str << "opengl : shader compile error"
        puts lv_str.join("\n")

        puts lv_compile_log_str
        exit
      end

      return lv_shader_id
    end

    #
    # set uniform matrix
    #
    def set_uniform_matrix_4f(name : String, value : GLM::Matrix)
      use do
        location = LibGL.get_uniform_location(@program_id, name)
        LibGL.uniform_matrix_4fv(location, 1, LibGL::FALSE, value.buffer)
      end
    end

    #
    # set uniform vector3
    #
    def set_uniform_vector3(name : String, value : GLM::Vector3)
      use do
        location = LibGL.get_uniform_location(@program_id, name)
        LibGL.uniform_3fv(location, 1, value.buffer)
      end
    end

    #
    # set uniform vector2
    #
    def set_uniform_vector2(name : String, value : GLM::Vector2)
      use do
        location = LibGL.get_uniform_location(@program_id, name)
        LibGL.uniform_2fv(location, 1, value.buffer)
      end
    end

    #
    # set uniform float
    #
    def set_uniform_float(name : String, value : Float32)
      use do
        location  = LibGL.get_uniform_location(@program_id, name)
        LibGL.uniform_1f(location,value)
      end
    end

    #
    # set uniform integer
    #
    def set_uniform_int(name : String, value : Int32)
      use do
        location  = LibGL.get_uniform_location(@program_id, name)
        LibGL.uniform_1i(location,value)
      end
    end

    def load_view_matrix(matrix : GLM::Matrix)
      use do
        set_uniform_matrix_4f("view", matrix)
      end
    end

    def load_projection_matrix(matrix : GLM::Matrix)
      use do
        set_uniform_matrix_4f("projection", matrix)
      end
    end

    def load_transformation(matrix : GLM::Matrix)
      use do
        set_uniform_matrix_4f("model", matrix)
      end
    end
  end
end
