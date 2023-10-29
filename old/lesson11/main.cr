require "gtk4"
require "./alert_dialog.cr"

class MainApp < Gtk::Application

  def initialize
    super(application_id: "hello.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

  end

  @[GObject::Virtual]
  def activate
    window = Gtk::ApplicationWindow.new(self)
    window.title = "Lesson11 : Alert dialog box using callbacks"
    window.maximize

    alert_dialog = AlertDialog.new(self,window,"a.txt")
    window.child = alert_dialog
    alert_dialog.present(->callback1(String),->callback2(String),->callback3(String))
    window.present()
  end

  def callback1(s : String)
  end

  def callback2(s : String)
  end

  def callback3(s : String)
  end
end

exit(MainApp.new.run)

