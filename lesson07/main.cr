require "gtk4"

UI = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkApplicationWindow" id="window">
    <property name="title">Lesson07 : Text editor with menu buttons via builder</property>
    <property name="default-width">600</property>
    <property name="default-height">400</property>
    <child>
      <object class="GtkBox">
        <property name="orientation">GTK_ORIENTATION_VERTICAL</property>
        <child>
          <object class="GtkBox">
            <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
            <child>
              <object class="GtkLabel">
                <property name="width-chars">10</property>
              </object>
            </child>
            <child>
              <object class="GtkButton" id="button_new">
                <property name="label">New</property>
              </object>
            </child>
            <child>
              <object class="GtkButton" id="button_open">
                <property name="label">Open</property>
              </object>
            </child>
            <child>
              <object class="GtkLabel">
                <property name="hexpand">TRUE</property>
              </object>
            </child>
            <child>
              <object class="GtkButton" id="button_save">
                <property name="label">Save</property>
              </object>
            </child>
            <child>
              <object class="GtkButton" id="button_close">
                <property name="label">Close</property>
              </object>
            </child>
            <child>
              <object class="GtkLabel">
                <property name="width-chars">10</property>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkNotebook" id="notebook">
            <property name="hexpand">TRUE</property>
            <property name="vexpand">TRUE</property>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
EOT

def get_file(filename : String) : String
  s = File.read_lines(filename).join("\n")
  return s
end

def new_file(notebook : Gtk::Notebook, count : Int32)
  scrolled_window    = Gtk::ScrolledWindow.new
  textview           = Gtk::TextView.new
  textbuffer         = textview.buffer
  textbuffer.text    = ""
  textview.wrap_mode = Gtk::WrapMode::WordChar
  scrolled_window.child = textview

  #
  # create a page with empty content
  #
  filename = "untitled #{count}"
  label = Gtk::Label.new(filename)
  #
  # append scrolled window to notebook
  #
  notebook.append_page(scrolled_window,label)
  #
  # expand the tabs
  #
  notebook_page = notebook.page(scrolled_window)
  notebook_page.tab_expand = true
end

def open_file(application : Gtk::Application, window : Gtk::ApplicationWindow, notebook : Gtk::Notebook)
  dialog = Gtk::FileChooserDialog.new(application: application, title: "Choose a file", action: :open)
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

        filename           = dialog.file.try(&.path).to_s
        scrolled_window    = Gtk::ScrolledWindow.new
        textview           = Gtk::TextView.new
        textbuffer         = textview.buffer
        textbuffer.text    = get_file(filename)
        textview.wrap_mode = Gtk::WrapMode::WordChar
        scrolled_window.child = textview

        label = Gtk::Label.new(filename)
        #
        # append scrolled window to notebook
        #
        notebook.append_page(scrolled_window,label)
        #
        # expand the tabs
        #
        notebook_page = notebook.page(scrolled_window)
        notebook_page.tab_expand = true
    end

    dialog.destroy
  end
  dialog.transient_for = window
  dialog.present
end

def save_file()
  puts "save file"
end

def close_file()
  puts "close file"
end

count_files = 1

#
# Note: Gio::ApplicationFlags::HandlesOpen is needed otherwise we get an error
#
app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::HandlesOpen)
app.activate_signal.connect do

  builder  = Gtk::Builder.new_from_string(UI, UI.bytesize.to_i64)
  window   = Gtk::ApplicationWindow.cast(builder["window"])
  #
  # important to set the window application to app
  #
  window.application = app

  #
  # get the notebook
  #
  notebook     = Gtk::Notebook.cast(builder["notebook"])
  button_new   = Gtk::Button.cast(builder["button_new"])
  button_open  = Gtk::Button.cast(builder["button_open"])
  button_save  = Gtk::Button.cast(builder["button_save"])
  button_close = Gtk::Button.cast(builder["button_close"])

  button_new.clicked_signal.connect do
    new_file(notebook,count_files)
    count_files = count_files + 1
  end

  button_open.clicked_signal.connect do
    open_file(app,window,notebook)
  end

  button_save.clicked_signal.connect do
    save_file()
  end

  button_close.clicked_signal.connect do
    close_file()
  end

  window.present
end

exit(app.run)
