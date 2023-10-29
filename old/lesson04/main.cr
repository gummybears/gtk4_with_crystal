require "gtk4"


def get_file(filename : String) : String
  s = File.read_lines(filename).join("\n")
  return s
end

args = ARGV

if args.size != 1
  puts "usage : ./a.out filename"
  exit
end

filename = args[0]
if File.exists?(filename) == false
  puts "usage : ./a.out #{filename}"
  exit
end

#
# Note: Gio::ApplicationFlags::HandlesOpen is needed otherwise we get an error
# GLib-GIO-CRITICAL **: 23:10:09.297: This application can not open files
#
app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::HandlesOpen)
app.open_signal.connect do
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Lesson03 : Scrolled window and TextView"
  window.set_default_size(400, 300)

  #
  # scrolled window
  #
  scrolled_window = Gtk::ScrolledWindow.new
  #
  # horizontal scrollbar is not visible, vertical scrollbar is
  #
  scrolled_window.hscrollbar_policy = Gtk::PolicyType::Automatic
  scrolled_window.vscrollbar_policy = Gtk::PolicyType::Automatic
  window.child = scrolled_window

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

  window.present
end

exit(app.run)
