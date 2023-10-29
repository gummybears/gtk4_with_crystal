#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

class Lesson004 < Gtk::Application

  property actions : Hash(String,Gio::SimpleAction)

  def initialize()
    super(application_id: "builder.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

    @actions = Hash(String,Gio::SimpleAction).new
    ["quit","open","new","save","saveas","cut","copy","paste","help", "about"].each do |a|
      @actions[a] = Gio::SimpleAction.new(a,nil)
    end
  end

  @[GObject::Virtual]
  def activate
    ui        = get_ui()
    builder   = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window    = Gtk::Window.cast(builder["window"])
    statusbar = Gtk::Statusbar.cast(builder["statusbar"])

    set_accels_for_action("app.quit", ["<Ctrl>Q"])
    @actions["quit"].activate_signal.connect do
      close_window(window)
    end
    add_action(@actions["quit"])

    set_accels_for_action("app.open", ["<Ctrl>O"])
    @actions["open"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Open\" not implemented")
    end
    add_action(@actions["open"])

    set_accels_for_action("app.new", ["<Ctrl>N"])
    @actions["new"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"New\" not implemented")
    end
    add_action(@actions["new"])

    set_accels_for_action("app.save", ["<Ctrl>S"])
    @actions["save"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Save\" not implemented")
    end
    add_action(@actions["save"])

    set_accels_for_action("app.saveas", ["<Shift><Ctrl>S"])
    @actions["saveas"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Save As\" not implemented")
    end
    add_action(@actions["saveas"])

    set_accels_for_action("app.cut", ["<Ctrl>X"])
    @actions["cut"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Cut\" not implemented")
    end
    add_action(@actions["cut"])

    set_accels_for_action("app.copy", ["<Ctrl>C"])
    @actions["copy"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Copy\" not implemented")
    end
    add_action(@actions["copy"])

    set_accels_for_action("app.paste", ["<Ctrl>V"])
    @actions["paste"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Paste\" not implemented")
    end
    add_action(@actions["paste"])

    set_accels_for_action("app.help", ["F1"])
    @actions["help"].activate_signal.connect do
      update_statusbar(statusbar,"Action \"Help\" not implemented")
    end
    add_action(@actions["help"])

    @actions["about"].activate_signal.connect do
#      update_statusbar(statusbar,"Gtk will issue the warning \"Couldn't unexport handle for GdkX11Toplevel surface, unsupported windowing system
#Opening in existing browser session\"")
      about_dialog(window)
    end
    add_action(@actions["about"])

    window.application = self
    window.present
  end

  def close_window(window)
    window.close
  end

  def update_statusbar(statusbar, text)
    statusbar.push(0,text)
  end

  def about_dialog(window)
    Gtk.show_about_dialog(
      parent:         window,
      name:           "About Lesson004",
      application:    self,
      program_name:   "About Dialog With ♥️",
      version:        "1.0.0",
      logo_icon_name: "emote-love-symbolic",
      website:        "https://github.com/gummybears/gtk4_with_crystal",
      website_label:  "Crystal Gtk-4 Demos",
      authors:        ["gummybears"],
      license_type:   Gtk::License::MitX11
      )
  end
end

exit(Lesson004.new.run)
