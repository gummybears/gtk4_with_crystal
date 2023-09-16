require "gtk4"
require "./ui.cr"
require "./texteditor.cr"
require "./texteditor_notebook.cr"

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
    # Menu bar from get_ui()
    #
    ui      = get_menu()
    builder = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    menubar = Gio::Menu.cast(builder["menubar"])

    #
    # attach menubar to application's menubar
    #
    self.menubar = menubar
    window.show_menubar = true

    #
    # important to set the window application to app
    #

    window.application = self
    window.present
  end
end

exit(TextEditorApp.new.run)
