#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

class ConstraintsGrid < Gtk::Widget
  # not needed def initialize
  # not needed   super()
  # not needed end
end

class Lesson010 < Gtk::Application

  def initialize()
    super(application_id: "builder_constraints.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate
    ui      = get_ui()

    #
    # Important to initialize an object of class ConstraintsGrid
    # as GtkBuilder will try to find a type "ConstraintsGrid"
    # see the builder code in get_ui()
    # where an object class is declared
    #
    # <object class="ConstraintsGrid">
    #
    #
    grid    = ConstraintsGrid.new
    builder = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window  = Gtk::Window.cast(builder["window"])

    window.application = self
    window.present
  end
end

exit(Lesson010.new.run)
