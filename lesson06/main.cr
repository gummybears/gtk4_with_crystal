require "gtk4"

def get_file(filename : String) : String
  s = File.read_lines(filename).join("\n")
  return s
end

args = ARGV
if args.size == 0
  puts "usage : ./a.out filename1 ..."
  exit
end

filenames = [] of String
args.each do |filename|
  if File.exists?(filename) == false
    puts "usage : ./a.out #{filename} ..."
    exit
  end

  filenames << filename
end
#
# Note: Gio::ApplicationFlags::HandlesOpen is needed otherwise we get an error
# GLib-GIO-CRITICAL **: 23:10:09.297: This application cannot open files
#
app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::HandlesOpen)
app.open_signal.connect do
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Lesson06 : Text editor with menu buttons"
  window.set_default_size(600, 400)

  #
  # menu buttons
  #
  vertical_box = Gtk::Box.new(:vertical,0)

  #
  # set vertical_box as the window child
  #
  window.child = vertical_box

  horizontal_box = Gtk::Box.new(:horizontal,0)
  vertical_box.append horizontal_box

  dummy1 = Gtk::Label.new
  dummy1.width_chars = 10

  dummy2 = Gtk::Label.new
  dummy2.hexpand = true

  dummy3 = Gtk::Label.new
  dummy3.width_chars = 10

  #
  # create buttons
  #
  button_new   = Gtk::Button.new_with_label("New")
  button_open  = Gtk::Button.new_with_label("Open")
  button_save  = Gtk::Button.new_with_label("Save")
  button_close = Gtk::Button.new_with_label("Close")

  #
  # append the labels and buttons to the horizontal box
  #
  horizontal_box.append(dummy1)
  horizontal_box.append(button_new)
  horizontal_box.append(button_open)
  horizontal_box.append(dummy2)
  horizontal_box.append(button_save)
  horizontal_box.append(button_close)
  horizontal_box.append(dummy3)

  #
  # create notebook
  #
  notebook = Gtk::Notebook.new
  notebook.hexpand = true
  notebook.vexpand = true

  #
  # append our notebook to the vertical box
  #
  vertical_box.append(notebook)

  #
  # read the files and display their content in
  #
  filenames.each do |filename|
    #
    # scrolled window
    #
    scrolled_window    = Gtk::ScrolledWindow.new
    textview           = Gtk::TextView.new
    textbuffer         = textview.buffer
    textbuffer.text    = get_file(filename)
    textview.wrap_mode = Gtk::WrapMode::WordChar
    scrolled_window.child = textview

    #
    # create a label with the filename as text
    #
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

  # window.close_request_signal.connect do
  #   exit
  #   true
  # end

  window.present
end

exit(app.run)
