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
# GLib-GIO-CRITICAL **: 23:10:09.297: This application can not open files
#
app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::HandlesOpen)
app.open_signal.connect do
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Lesson05 : Notebook file viewer"
  window.set_default_size(600, 400)
  notebook = Gtk::Notebook.new

  filenames.each do |filename|
    #
    # scrolled window
    #
    scrolled_window = Gtk::ScrolledWindow.new

    #
    # textview and textbuffer
    #
    textview           = Gtk::TextView.new
    textbuffer         = textview.buffer
    textbuffer.text    = get_file(filename)
    textview.wrap_mode = Gtk::WrapMode::WordChar

    #
    # disable edit mode, read-only view
    #
    textview.editable = false
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

  window.child = notebook
  window.present
end

exit(app.run)
