require "gtk4"

app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::None)
app.activate_signal.connect do
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Lesson00 : ApplicationWindow"
  window.set_default_size(400, 300)
  window.present
end

exit(app.run)
