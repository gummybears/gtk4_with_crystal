class TextEditorNotebook

  property application  : Gtk::Application
  property window       : Gtk::ApplicationWindow
  property notebook     : Gtk::Notebook
  property builder      : Gtk::Builder

  property fullscreen_state : Bool = false

  property editors      : Array(TextEditor) = [] of TextEditor
  property nr_new_files : Int32 = 1

  def initialize(application : Gtk::Application, window : Gtk::ApplicationWindow, notebook : Gtk::Notebook, builder : Gtk::Builder)
    @notebook    = notebook
    @builder     = builder
    @application = application
    @window      = window

    #
    # Menu actions
    #
    menu_actions()

    #
    # Menu accelarators
    #
    menu_accelerators()

  end

  @[GObject::Virtual]
  def activate
  end

  def open_file_dialog
    dialog = Gtk::FileChooserDialog.new(application: @application, title: "Choose a file", action: :open)
    dialog.add_button("Cancel", Gtk::ResponseType::Cancel.value)
    dialog.add_button("Open",   Gtk::ResponseType::Accept.value)

    #
    # create a file filter
    #
    filefilter = Gtk::FileFilter.new
    filefilter.add_pattern("*.txt")
    filefilter.add_pattern("*.cr")

    #
    # add file filter to dialog
    #
    dialog.filter = filefilter

    #
    # cannot create new folders when using the filechooser dialog
    #
    dialog.create_folders = false

    #
    # set current folder to current directory
    #
    dialog.current_folder = Gio::File.new_for_path(Dir.current)

    dialog.response_signal.connect do |response|
      case Gtk::ResponseType.from_value(response)
        when .cancel?

        when .accept?
          filename = dialog.file.try(&.path).to_s
          texteditor = TextEditor.new(filename,@notebook)
          texteditor.add()
          @editors << texteditor
      end

      dialog.destroy
    end
    dialog.transient_for = @window
    dialog.present
  end

  def save_file_dialog() : Bool
    result = false
    dialog = Gtk::FileChooserDialog.new(application: @application, title: "Save a file", action: :save)
    dialog.add_button("Cancel", Gtk::ResponseType::Cancel.value)
    dialog.add_button("Save",   Gtk::ResponseType::Accept.value)

    #
    # create a file filter
    #
    filefilter = Gtk::FileFilter.new
    filefilter.add_pattern("*.txt")
    filefilter.add_pattern("*.cr")

    #
    # add file filter to dialog
    #
    dialog.filter = filefilter

    #
    # cannot create new folders when using the filechooser dialog
    #
    dialog.create_folders = false

    #
    # set current folder to current directory
    #
    dialog.current_folder = Gio::File.new_for_path(Dir.current)

    dialog.response_signal.connect do |response|
      case Gtk::ResponseType.from_value(response)
        when .cancel?
          result = false

        when .accept?
          filename = dialog.file.try(&.path).to_s
          page     = @notebook.current_page
          begin
            @editors[page].save_file(filename)
            result = true
          rescue
            puts "cannot find editor, exit"
            exit
          end
      end

      dialog.destroy
    end
    dialog.transient_for = @window
    dialog.present
    return result
  end

  def new_file

    filename   = "untitled #{@nr_new_files}"
    texteditor = TextEditor.new(filename,@notebook)
    texteditor.add()
    @editors << texteditor

    @nr_new_files += 1
  end

  def open_file()
    open_file_dialog()
  end

  def save_file() : Bool
    return save_file_dialog()
  end

  def close_file()
    page = @notebook.current_page
    begin
      if @editors[page]
        if @editors[page].modified
          if save_file()
            notebook.remove_page(page)
          end
        else
          @notebook.remove_page(page)
        end

        #
        # remove our editor from @editors
        #
        @editors.delete_at(page)
      end
    rescue
      puts "cannot find editor, exit"
      exit
    end
  end

  def menu_accelerators()
    @application.set_accels_for_action("app.quit",         ["<Ctrl>Q"])
    @application.set_accels_for_action("win.fullscreen",   ["<Ctrl>F"])
    @application.set_accels_for_action("app.new",          ["<Ctrl>N"])
    @application.set_accels_for_action("app.open",         ["<Ctrl>O"])
    @application.set_accels_for_action("app.save",         ["<Ctrl>S"])
    @application.set_accels_for_action("app.close",        ["<Ctrl>W"])

    @application.set_accels_for_action("app.cut",          ["<Ctrl>X"])
    @application.set_accels_for_action("app.copy",         ["<Ctrl>C"])
    @application.set_accels_for_action("app.paste",        ["<Ctrl>V"])
    @application.set_accels_for_action("app.selectall",    ["<Ctrl>A"])
  end

  def menu_actions()
    action_quit = Gio::SimpleAction.new("quit",nil)
    action_quit.activate_signal.connect do
      quit_application()
    end

    action_fullscreen = Gio::SimpleAction.new_stateful("fullscreen",nil, false)
    action_fullscreen.change_state_signal.connect do
      fullscreen_changed(action_fullscreen)
    end

    action_new = Gio::SimpleAction.new("new",nil)
    action_new.activate_signal.connect do
      new_file()
    end

    action_open = Gio::SimpleAction.new("open",nil)
    action_open.activate_signal.connect do
      open_file()
    end

    action_save = Gio::SimpleAction.new("save",nil)
    action_save.activate_signal.connect do
      save_file()
    end

    action_close = Gio::SimpleAction.new("close",nil)
    action_close.activate_signal.connect do
      close_file()
    end

    action_cut = Gio::SimpleAction.new("cut",nil)
    action_cut.activate_signal.connect do
      edit_cut()
    end

    action_copy = Gio::SimpleAction.new("copy",nil)
    action_copy.activate_signal.connect do
      edit_copy()
    end

    action_paste = Gio::SimpleAction.new("paste",nil)
    action_paste.activate_signal.connect do
      edit_paste()
    end

    action_selectall = Gio::SimpleAction.new("selectall",nil)
    action_selectall.activate_signal.connect do
      edit_selectall()
    end

    @application.add_action(action_quit)
    @application.add_action(action_new)
    @application.add_action(action_open)
    @application.add_action(action_save)
    @application.add_action(action_close)

    @application.add_action(action_cut)
    @application.add_action(action_copy)
    @application.add_action(action_paste)
    @application.add_action(action_selectall)

    @window.add_action(action_fullscreen)
  end

  def edit_cut()
    puts "cut"
  end

  def edit_copy()
    puts "copy"
  end

  def edit_paste()
    puts "paste"
  end

  def edit_selectall()
    puts "select all"
  end

  def fullscreen_changed(action)
    if @fullscreen_state
      @window.unmaximize
    else
      @window.maximize
    end

    @fullscreen_state = !@fullscreen_state
    action.state = @fullscreen_state
  end

  def quit_application()
    @editors.each do |editor|
      if editor.modified
        return
      end
    end
    exit()
  end
end

