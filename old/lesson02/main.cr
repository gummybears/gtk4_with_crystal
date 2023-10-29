require "gtk4"

def click1_cb(button : Gtk::Button)
  s = button.label()
  if s == "Hello."
    button.label = "Good-bye"
  else
    button.label = "Hello."
  end
end

def click2_cb(window : Gtk::ApplicationWindow)
  window.close
end

app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::None)
app.activate_signal.connect do
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Lesson01 : Buttons"
  window.set_default_size(400, 300)

  box = Gtk::Box.new(:vertical,5)
  box.homogeneous = true

  btn1 = Gtk::Button.new_with_label("Hello.")
  btn1.clicked_signal.connect do
    click1_cb(btn1)
  end

  btn2 = Gtk::Button.new_with_label("Close.")
  btn2.clicked_signal.connect do
    click2_cb(window)
  end

  box.append btn1
  box.append btn2

  window.child = box
  window.present
end

exit(app.run)
