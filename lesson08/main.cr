require "gtk4"
require "./ui.cr"

#
# def file_changed_callback(notebook : Gtk::Notebook, textbuffer : Gtk::TextBuffer,filename : String)
#   #puts "textbuffer changed #{filename}"
# end
#
#
# def new_file(notebook : Gtk::Notebook, button : Gtk::Button, count : Int32)
#   filename = "untitled #{count}"
#   notebook_page_add(notebook,filename)
#   button.sensitive = true
# end
##
# def get_textview(notebook : Gtk::Notebook) : Gtk::TextView
#   page_index      = notebook.current_page
#   scrolled_window = Gtk::ScrolledWindow.cast(notebook.nth_page(page_index))
#   textview        = Gtk::TextView.new
#   if scrolled_window
#     textview = Gtk::TextView.cast(scrolled_window.child)
#   end
#   return textview
# end
#
# def save_file(notebook : Gtk::Notebook)
#
#   textview   = get_textview(notebook)
#   textbuffer = textview.buffer
#   if textbuffer.modified
#     contents = textbuffer.text
#     # puts contents
#   end
# end
#
# #
# # buggy code, depends on the initial state whether there
# # are notebook pages. Need to refactor all this code
# # into a seperate class and keep track of the number of pages
# # created
# #
# def close_file(notebook : Gtk::Notebook, button : Gtk::Button)
#   nr_pages = notebook.n_pages
#   if nr_pages == 0
#     button.sensitive = false
#     return
#   else
#     button.sensitive = true
#   end
#   page_index = notebook.current_page
#   notebook.remove_page(page_index)
# end


#
# From lesson07
#
enum FileStatus
  None
  New
  Open
  Save
  Close
end

class FileinEditor
  property filename = ""
  property status   : FileStatus = FileStatus::None

end

#class Files
#
#end

class TextEditor
  property filename : String
  property basename : String

  property notebook : Gtk::Notebook

  def initialize(filename : String, notebook : Gtk::Notebook)
    @filename = filename

    if @filename =~ /untitled/
      @basename = @filename
    else
      @basename = File.basename(filename)
    end

    @notebook = notebook
  end

  @[GObject::Virtual]
  def activate
  end

  def read_file(filename : String) : String
    s = File.read_lines(filename).join("\n")
    return s
  end

  def file_changed_callback(textbuffer : Gtk::TextBuffer)
    #puts "textbuffer changed #{filename}"
  end

  def add()
    scrolled_window    = Gtk::ScrolledWindow.new
    textview           = Gtk::TextView.new

    textbuffer = textview.buffer
    if @basename =~ /untitled/
      textbuffer.text = ""
    else
      textbuffer.text = read_file(@basename)

      #
      # when we edit the file, ie  the textview changes we need to know about it
      # only for the files we opened
      #
      textbuffer.changed_signal.connect do
        file_changed_callback(textbuffer)
      end
    end
    textview.wrap_mode = Gtk::WrapMode::WordChar
    scrolled_window.child = textview

    #
    # create a page with empty content
    #
    if @basename =~ /untitled/
      label = Gtk::Label.new(@basename)
    else
      label = Gtk::Label.new(File.basename(@basename))
    end

    #
    # append scrolled window to notebook
    #
    page_index = @notebook.append_page(scrolled_window,label)

    #
    # expand the tabs
    #
    notebook_page = @notebook.page(scrolled_window)
    notebook_page.tab_expand = true

    #
    # set the notebook's current page
    #
    @notebook.current_page = page_index
  end
end

class TextEditorNotebook

  property application  : Gtk::Application
  property window       : Gtk::Window
  property notebook     : Gtk::Notebook
  property builder      : Gtk::Builder
  property button_new   : Gtk::Button
  property button_open  : Gtk::Button
  property button_save  : Gtk::Button
  property button_close : Gtk::Button

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
          # TODO texteditor = TextEditor.new(filename,@notebook)
          # TODO texteditor.add()
          # TODO
          # TODO #
          # TODO # enable buttons save and close
          # TODO #
          # TODO @button_save.sensitive  = true
          # TODO @button_close.sensitive = true

      end

      dialog.destroy
    end
    dialog.transient_for = @window
    dialog.present
  end

  def new_file
    filename = "untitled"
    texteditor = TextEditor.new(filename,@notebook)
    texteditor.add()

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

class TextEditorApp < Gtk::Application
  property nr_files = 0
  property filename : String = ""

  def initialize
    #
    # Note: Gio::ApplicationFlags::HandlesOpen is needed otherwise we get an error
    #
    super(application_id: "hello.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

  end

  @[GObject::Virtual]
  def activate

    ui       = get_ui()
    builder  = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window   = Gtk::ApplicationWindow.cast(builder["window"])
    notebook = TextEditorNotebook.new(self,window,Gtk::Notebook.cast(builder["notebook"]), builder)

    #
    # important to set the window application to app
    #
    window.application = self
    window.present
  end

end

exit(TextEditorApp.new.run)
