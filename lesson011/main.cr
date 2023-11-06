#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

class Lesson011 < Gtk::Application

  def initialize()
    super(application_id: "cursors.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate
    ui      = get_ui()

    builder = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window  = Gtk::Window.cast(builder["window"])
    window.application = self
    window.present
  end
end

exit(Lesson011.new.run)
