require "gtk4"

def text()
  s = "Once upon a time, there was an old man who was called Taketori-no-Okina.
It is a japanese word that means a man whose work is making bamboo baskets.\n
One day, he went into a hill and found a shining bamboo.
What a mysterious bamboo it is! he said.\n
He cut it, then there was a small cute baby girl in it.\n
The girl was shining faintly.
He thought this baby girl is a gift from Heaven and took her home.\n
His wife was surprized at his story.
They were very happy because they had no children."

  return s
end

app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::None)
app.activate_signal.connect do
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Lesson02 : Scrolled window and TextView"
  window.set_default_size(400, 300)

  #
  # scrolled window
  #
  scrolled_window = Gtk::ScrolledWindow.new
  window.child    = scrolled_window

  #
  # textview and textbuffer
  #
  textview           = Gtk::TextView.new
  textbuffer         = textview.buffer
  textbuffer.text    = text()
  textview.wrap_mode = Gtk::WrapMode::WordChar

  scrolled_window.child = textview

  window.present
end

exit(app.run)
