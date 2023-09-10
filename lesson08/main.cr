require "gtk4"
require "./ui.cr"

# def get_file(filename : String) : String
#   s = File.read_lines(filename).join("\n")
#   return s
# end
#
# def file_changed_callback(notebook : Gtk::Notebook, textbuffer : Gtk::TextBuffer,filename : String)
#   #puts "textbuffer changed #{filename}"
# end
#
# def notebook_page_add(notebook : Gtk::Notebook, filename : String)
#
#   scrolled_window    = Gtk::ScrolledWindow.new
#   textview           = Gtk::TextView.new
#
#   textbuffer = textview.buffer
#   if filename =~ /untitled/
#     textbuffer.text = ""
#   else
#     textbuffer.text = get_file(filename)
#
#     #
#     # when we edit the file, ie  the textview changes we need to know about it
#     # only for the files we opened
#     #
#
#     textbuffer.changed_signal.connect do
#       file_changed_callback(notebook,textbuffer,filename)
#     end
#   end
#   textview.wrap_mode = Gtk::WrapMode::WordChar
#   scrolled_window.child = textview
#
#   #
#   # create a page with empty content
#   #
#   if filename =~ /untitled/
#     label = Gtk::Label.new(filename)
#   else
#     label = Gtk::Label.new(File.basename(filename))
#   end
#
#   #
#   # append scrolled window to notebook
#   #
#   page_index = notebook.append_page(scrolled_window,label)
#
#   #
#   # expand the tabs
#   #
#   notebook_page = notebook.page(scrolled_window)
#   notebook_page.tab_expand = true
#
#   #
#   # set the notebook's current page
#   #
#   notebook.current_page = page_index
# end
#
# def new_file(notebook : Gtk::Notebook, button : Gtk::Button, count : Int32)
#   filename = "untitled #{count}"
#   notebook_page_add(notebook,filename)
#   button.sensitive = true
# end
#
# def open_file(application : Gtk::Application, window : Gtk::ApplicationWindow, notebook : Gtk::Notebook, button : Gtk::Button)
#   dialog = Gtk::FileChooserDialog.new(application: application, title: "Choose a file", action: :open)
#   dialog.add_button("Cancel", Gtk::ResponseType::Cancel.value)
#   dialog.add_button("Open",   Gtk::ResponseType::Accept.value)
#
#   #
#   # create a file filter
#   #
#   filefilter = Gtk::FileFilter.new
#   filefilter.add_pattern("*.txt")
#   filefilter.add_pattern("*.cr")
#
#   #
#   # add file filter to dialog
#   #
#   dialog.filter = filefilter
#
#   #
#   # cannot create new folders when using the filechooser dialog
#   #
#   dialog.create_folders = false
#
#   #
#   # set current folder to current directory
#   #
#   dialog.current_folder = Gio::File.new_for_path(Dir.current)
#
#   dialog.response_signal.connect do |response|
#     case Gtk::ResponseType.from_value(response)
#       when .cancel?
#
#       when .accept?
#         button.sensitive = true
#         filename = dialog.file.try(&.path).to_s
#         notebook_page_add(notebook,filename)
#     end
#
#     dialog.destroy
#   end
#   dialog.transient_for = window
#   dialog.present
# end
#
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

class TextEditor #< Gtk::Notebook

  property notebook : Gtk::Notebook
  property builder  : Gtk::Builder

  def initialize(notebook : Gtk::Notebook, builder : Gtk::Builder)
    @notebook = notebook
    @builder  = builder

    connect_signals()
  end

  @[GObject::Virtual]
  def activate
  end

  def connect_signals()
    button_new   = Gtk::Button.cast(@builder["button_new"])
    button_open  = Gtk::Button.cast(@builder["button_open"])
    button_save  = Gtk::Button.cast(@builder["button_save"])
    button_close = Gtk::Button.cast(@builder["button_close"])

    button_new.clicked_signal.connect do
      puts "new"
      #new_file(notebook,button_close,count_files)
      #count_files = count_files + 1
    end

    button_open.clicked_signal.connect do
      puts "open"
      #open_file(app,window,notebook, button_close)
    end

    button_save.clicked_signal.connect do
      puts "save"
      #save_file(notebook)
    end

    button_close.clicked_signal.connect do
      puts "close"
      #close_file(notebook, button_close)
      #count_files = count_files - 1
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

    ui  = get_ui()
    builder = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window  = Gtk::ApplicationWindow.cast(builder["window"])

    #
    # connect signals
    #
    notebook = TextEditor.new(Gtk::Notebook.cast(builder["notebook"]), builder)
    # old code signals(builder)

    #
    # important to set the window application to app
    #
    window.application = self
    window.present
  end

  # old code def signals(builder)
  # old code
  # old code   button_new   = Gtk::Button.cast(builder["button_new"])
  # old code   button_open  = Gtk::Button.cast(builder["button_open"])
  # old code   button_save  = Gtk::Button.cast(builder["button_save"])
  # old code   button_close = Gtk::Button.cast(builder["button_close"])
  # old code
  # old code   button_new.clicked_signal.connect do
  # old code     #new_file(notebook,button_close,count_files)
  # old code     #count_files = count_files + 1
  # old code   end
  # old code
  # old code   button_open.clicked_signal.connect do
  # old code     #open_file(app,window,notebook, button_close)
  # old code   end
  # old code
  # old code   button_save.clicked_signal.connect do
  # old code     #save_file(notebook)
  # old code   end
  # old code
  # old code   button_close.clicked_signal.connect do
  # old code     #close_file(notebook, button_close)
  # old code     #count_files = count_files - 1
  # old code   end
  # old code end
end

exit(TextEditorApp.new.run)
