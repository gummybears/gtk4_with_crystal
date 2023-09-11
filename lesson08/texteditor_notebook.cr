class TextEditorNotebook

  property application  : Gtk::Application
  property window       : Gtk::Window
  property notebook     : Gtk::Notebook
  property builder      : Gtk::Builder
  property button_new   : Gtk::Button
  property button_open  : Gtk::Button
  property button_save  : Gtk::Button
  property button_close : Gtk::Button

  property current_editor : TextEditor
  property nr_files     : Int32 = 0

  def initialize(application : Gtk::Application, window : Gtk::ApplicationWindow, notebook : Gtk::Notebook, builder : Gtk::Builder)
    @notebook    = notebook
    @builder     = builder
    @application = application
    @window      = window

    @button_new   = Gtk::Button.cast(@builder["button_new"])
    @button_open  = Gtk::Button.cast(@builder["button_open"])
    @button_save  = Gtk::Button.cast(@builder["button_save"])
    @button_close = Gtk::Button.cast(@builder["button_close"])

    #
    # disable buttons save and close
    #
    @button_save.sensitive  = false
    @button_close.sensitive = false

    @current_editor = TextEditor.new("",notebook)
    connect_signals()
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
          @current_editor = texteditor

          #
          # enable buttons save and close
          #
          @button_save.sensitive  = true
          @button_close.sensitive = true

      end

      dialog.destroy
    end
    dialog.transient_for = @window
    dialog.present
  end

  def get_textview : Gtk::TextView
    page_index      = @notebook.current_page
    scrolled_window = Gtk::ScrolledWindow.cast(@notebook.nth_page(page_index))
    textview        = Gtk::TextView.new
    if scrolled_window
      textview = Gtk::TextView.cast(scrolled_window.child)
    end
    return textview
  end

  def save_file(filename : String)
    contents   = ""
    textview   = get_textview()
    textbuffer = textview.buffer

    if textbuffer.modified
      contents = textbuffer.text

      if File.exists?(filename)
        file = File.open(filename,"w")
        file.puts contents
        file.close
      else
        # new file
        file = File.new(filename,"w")
        file.puts contents
        file.close
      end

      #puts contents
    end
  end

  def save_file_dialog
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

        when .accept?
          filename = dialog.file.try(&.path).to_s
          save_file(filename)
      end

      dialog.destroy
    end
    dialog.transient_for = @window
    dialog.present
  end

  def new_file
    filename   = "untitled"
    texteditor = TextEditor.new(filename,@notebook)
    texteditor.add()
    @current_editor = texteditor

    #
    # enable buttons save and close
    #
    @button_save.sensitive  = true
    @button_close.sensitive = true
  end

  def open_file
    open_file_dialog()
  end

  def save_file
    save_file_dialog()
  end

  def connect_signals()

    @button_new.clicked_signal.connect do
      new_file()
    end

    @button_open.clicked_signal.connect do
      open_file()
    end

    @button_save.clicked_signal.connect do
      save_file()
    end

    @button_close.clicked_signal.connect do
      page_index = @notebook.current_page
      @notebook.remove_page(page_index)
    end

  end
end

