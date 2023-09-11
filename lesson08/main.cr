require "gtk4"
require "./ui.cr"
require "./texteditor.cr"
require "./texteditor_notebook.cr"

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
