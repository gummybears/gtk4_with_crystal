class TextEditorNotebook

  property application       : Gtk::Application
  property window            : Gtk::ApplicationWindow
  property notebook          : Gtk::Notebook
  property builder           : Gtk::Builder

  property fullscreen_state  : Bool = false

  property editors           : Array(TextEditor) = [] of TextEditor
  property nr_new_files      : Int32 = 1
  property nr_files          : Int32 = 0

  property original_title    : String

  property action_quit       : Gio::SimpleAction
  property action_fullscreen : Gio::SimpleAction
  property action_save       : Gio::SimpleAction
  property action_close      : Gio::SimpleAction
  property action_new        : Gio::SimpleAction
  property action_open       : Gio::SimpleAction
  property action_cut        : Gio::SimpleAction
  property action_copy       : Gio::SimpleAction
  property action_paste      : Gio::SimpleAction
  property action_selectall  : Gio::SimpleAction
  property action_about      : Gio::SimpleAction

  def initialize(application : Gtk::Application, window : Gtk::ApplicationWindow, notebook : Gtk::Notebook, builder : Gtk::Builder)
    @notebook       = notebook
    @builder        = builder
    @application    = application
    @window         = window
    @original_title = @window.title.not_nil!

    @action_quit       = Gio::SimpleAction.new("quit",nil)
    @action_fullscreen = Gio::SimpleAction.new_stateful("fullscreen",nil, false)
    @action_save       = Gio::SimpleAction.new("save",nil)
    @action_close      = Gio::SimpleAction.new("close",nil)
    @action_new        = Gio::SimpleAction.new("new",nil)
    @action_open       = Gio::SimpleAction.new("open",nil)
    @action_cut        = Gio::SimpleAction.new("cut",nil)
    @action_copy       = Gio::SimpleAction.new("copy",nil)
    @action_paste      = Gio::SimpleAction.new("paste",nil)
    @action_selectall  = Gio::SimpleAction.new("selectall",nil)
    @action_about      = Gio::SimpleAction.new("about",nil)
    @action_alert      = Gio::SimpleAction.new("alert",nil)

    @window.close_request_signal.connect do
      quit_application()
      true
    end

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

          @nr_files += 1
          check_for_editors()

      end

      dialog.destroy
    end
    dialog.transient_for = @window
    dialog.present
  end

  def cancel_save()
  end

  def dont_save()
  end

  def alert_dialog()
    ui       = get_alert_dialog(filename)
    builder  = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    dialog   = Gtk::Dialog.cast(builder["alert_dialog"])
    dialog.transient_for = @window

    button_cancel = Gtk::Button.cast(builder["button_cancel"])
    button_dont   = Gtk::Button.cast(builder["button_dont"])
    button_save   = Gtk::Button.cast(builder["button_save"])

    button_cancel.clicked_signal.connect do
      puts "cancel"
    end


    button_dont.clicked_signal.connect do
      puts "dont"
    end


    button_save.clicked_signal.connect do
      save_file_dialog()
    end

    dialog.present
  end

  def about_dialog()
    Gtk.show_about_dialog(
      #nil,
      parent:         @window,
      name:            "About TextEditor",
      application:    @application,
      program_name:   "About Dialog With ♥️",
      version:        "1.0.0",
      logo_icon_name: "emote-love-symbolic",
      website:        "https://github.com/gummybears/gtk4_with_crystal",
      website_label:  "Crystal Gtk-4 Demos",
      authors:        ["gummybears"],
      license_type:   Gtk::License::MitX11
      )

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
    @nr_files     += 1

    check_for_editors()

  end

  def open_file()
    open_file_dialog()
  end

  def check_for_editors()

    update_window_title()

    #if @editors.size == 0
    if @nr_files == 0
      @action_save.enabled      = false
      @action_close.enabled     = false
      @action_cut.enabled       = false
      @action_copy.enabled      = false
      @action_paste.enabled     = false
      @action_selectall.enabled = false
    else
      @action_save.enabled      = true
      @action_close.enabled     = true
      @action_cut.enabled       = true
      @action_copy.enabled      = true
      @action_paste.enabled     = true
      @action_selectall.enabled = true
    end
  end

  def save_file() : Bool
    check_for_editors()

    return save_file_dialog()
  end

  def close_file()
    page = @notebook.current_page
    begin
      if @editors[page]
        if @editors[page].modified
          if save_file()
            notebook.remove_page(page)
            #
            # remove our editor from @editors
            #
            @editors.delete_at(page)
            @nr_files -= 1
            check_for_editors()

          end
        else
          @notebook.remove_page(page)
          #
          # remove our editor from @editors
          #
          @editors.delete_at(page)
          @nr_files -= 1
          check_for_editors()

        end

      end
    rescue
    end
  end

  def update_window_title()
    #s = @window.title.not_nil!
    x = @original_title + " : number files #{@nr_files}"
    @window.title = x
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
    @action_about.activate_signal.connect do
      about_dialog()
    end

    # old code @action_alert.activate_signal.connect do
    # old code   alert_dialog()
    # old code end

    @action_quit.activate_signal.connect do
      quit_application()
    end

    @action_fullscreen.change_state_signal.connect do
      fullscreen_changed(action_fullscreen)
    end

    @action_save.activate_signal.connect do
      save_file()
    end

    @action_close.activate_signal.connect do
      close_file()
    end

    #
    # disabled menu items Save and Close
    #
    @action_save.enabled = false
    @action_close.enabled = false

    @action_new.activate_signal.connect do
      @action_save.enabled = true
      @action_close.enabled = true
      new_file()
    end

    @action_open.activate_signal.connect do
      @action_save.enabled  = true
      @action_close.enabled = true
      open_file()
    end

    @action_cut.activate_signal.connect do
      edit_cut()
    end

    @action_copy.activate_signal.connect do
      edit_copy()
    end

    @action_paste.activate_signal.connect do
      edit_paste()
    end

    @action_selectall.activate_signal.connect do
      edit_selectall()
    end

    @application.add_action(@action_quit)
    @application.add_action(@action_new)
    @application.add_action(@action_open)
    @application.add_action(@action_save)
    @application.add_action(@action_close)

    @application.add_action(@action_cut)
    @application.add_action(@action_copy)
    @application.add_action(@action_paste)
    @application.add_action(@action_selectall)

    @application.add_action(@action_about)
    @application.add_action(@action_alert)

    @window.add_action(@action_fullscreen)
  end

  def edit_cut()
    puts "cut"
  end

  def edit_copy()
    puts "copy"

    page = @notebook.current_page
    begin
      if @editors[page]
        textview = @editors[page].get_textview()
      end
    end
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

