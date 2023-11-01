#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./interactive_grid.cr"

class Lesson007 < Gtk::Application

  def initialize()
    super(application_id: "interactive_constraints.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate

    window       = Gtk::Window.new
    window.title = "Interactive Constraints"
    window.set_default_size(260,-1)

    box  = Gtk::Box.new(orientation: :vertical,spacing: 12)
    grid = InteractveGrid.new(box)

    window.child       = box
    window.application = self
    window.present
  end


end

exit(Lesson007.new.run)
