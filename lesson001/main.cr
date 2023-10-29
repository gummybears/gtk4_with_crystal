#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

class Lesson001 < Gtk::Application
  @@id : Int32 = 1
  property app_new        : Gio::SimpleAction
  property app_open       : Gio::SimpleAction
  property app_save       : Gio::SimpleAction
  property app_saveas     : Gio::SimpleAction
  property app_quit       : Gio::SimpleAction
  #
  property file_theme     : Gio::SimpleAction
  property file_color     : Gio::SimpleAction
  property file_shape     : Gio::SimpleAction
  property file_bold      : Gio::SimpleAction
  #
  property app_about      : Gio::SimpleAction
  property app_logo       : Gio::SimpleAction

  def initialize()
    super(application_id: "hello#{@@id}.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

    @app_new    = Gio::SimpleAction.new("new",nil)
    @app_quit   = Gio::SimpleAction.new("quit",nil)
    @app_open   = Gio::SimpleAction.new("open",nil)
    @app_save   = Gio::SimpleAction.new("save",nil)
    @app_saveas = Gio::SimpleAction.new("saveas",nil)
    @app_logo   = Gio::SimpleAction.new("logo",nil)

    @file_theme = Gio::SimpleAction.new("dark",nil)
    @file_color = Gio::SimpleAction.new("color",nil)
    @file_shape = Gio::SimpleAction.new("shape",nil)
    @file_bold  = Gio::SimpleAction.new("bold",nil)
    @app_about  = Gio::SimpleAction.new("about",nil)
  end

  @[GObject::Virtual]
  def activate

    ui       = get_ui()
    builder  = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window   = Gtk::ApplicationWindow.cast(builder["window"])
    window.set_default_size(600,400)

    #
    # Menu bar from get_menu()
    #
    ui       = get_menu()
    builder2 = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    menubar  = Gio::Menu.cast(builder2["menubar"])

    set_accels_for_action("app.quit", ["<Ctrl>Q"])
    @app_quit.activate_signal.connect do
      close_window(window)
    end
    add_action(@app_quit)

    set_accels_for_action("app.new", ["<Ctrl>N"])
    @app_new.activate_signal.connect do
      new_application()
      true
    end
    add_action(@app_new)

    set_accels_for_action("app.open", ["<Ctrl>O"])
    @app_open.activate_signal.connect do
      open_file_dialog(builder,window)
    end
    add_action(@app_open)

    set_accels_for_action("app.save", ["<Ctrl>S"])
    @app_save.activate_signal.connect do
      save_file_dialog(window)
    end
    add_action(@app_save)

    set_accels_for_action("app.saveas", ["<Shift><Ctrl>S"])
    @app_saveas.activate_signal.connect do
      saveas_file_dialog(window)
    end
    add_action(@app_saveas)

    set_accels_for_action("app.logo", ["<Ctrl>L"])
    @app_logo.activate_signal.connect do
      logo_dialog(window)
    end
    add_action(@app_logo)

    set_accels_for_action("app.bold", ["<Shift><Ctrl>B"])
    @file_bold.activate_signal.connect do
      bold_theme(window)
    end
    add_action(@file_bold)

    @file_theme.activate_signal.connect do
      dark_theme(window)
    end
    add_action(@file_theme)

    set_accels_for_action("color.red",   ["<Ctrl>R"])
    set_accels_for_action("color.blue",  ["<Ctrl>B"])
    set_accels_for_action("color.green", ["<Ctrl>G"])

    color_variant_type = GLib::VariantType.new("s")
    @file_color        = Gio::SimpleAction.new_stateful("color", color_variant_type, "red")
    @file_color.activate_signal.connect(->color_changed(Gio::SimpleAction, GLib::Variant))
    add_action(@file_color)

    shape_variant_type = GLib::VariantType.new("s")
    @file_shape        = Gio::SimpleAction.new_stateful("shape", shape_variant_type, "square")
    @file_shape.activate_signal.connect(->shape_changed(Gio::SimpleAction, GLib::Variant))
    add_action(@file_shape)

    set_accels_for_action("about", ["<Ctrl>A"])
    @app_about.activate_signal.connect do
      help_about_dialog(window)
    end
    add_action(@app_about)

    window.close_request_signal.connect do
      quit_application()
      true
    end

    #
    # attach menubar to application's menubar
    #
    self.menubar = menubar
    window.show_menubar = true

    #
    # important to set the window application to self
    #
    window.application = self
    window.present
  end

  def color_changed(action : Gio::SimpleAction, parameter : GLib::Variant)
    #
    # set color menu item state
    #
    action.state = parameter
  end

  def shape_changed(action : Gio::SimpleAction, parameter : GLib::Variant)
    #
    # set shape menu item state
    #
    action.state = parameter
  end

  def quit_application()
    exit()
  end

  def close_window(window)
    window.close
  end

  def new_application()
    @@id = @@id + 1
    Lesson001.new.run
  end

  def open_file_dialog(builder,window)
    dialog = Gtk::FileChooserDialog.new(application: self, title: "Choose a file", action: :open)
    dialog.add_button("Cancel", Gtk::ResponseType::Cancel.value)
    dialog.add_button("Open",   Gtk::ResponseType::Accept.value)

    #
    # create a file filter
    #
    filefilter = Gtk::FileFilter.new
    filefilter.add_pattern("*.txt")
    filefilter.add_pattern("*.cr")

    #
    # add file filter to dialog
    #
    dialog.filter = filefilter

    #
    # cannot create new folders when using the filechooser dialog
    #
    dialog.create_folders = false

    #
    # set current folder to current directory
    #
    dialog.current_folder = Gio::File.new_for_path(Dir.current)

    dialog.response_signal.connect do |response|
      case Gtk::ResponseType.from_value(response)
        when .cancel?

        when .accept?
          filename   = dialog.file.try(&.path).to_s
          textbuffer = Gtk::TextBuffer.cast(builder["buffer"])
          statusbar  = Gtk::Statusbar.cast(builder["status"])
          textbuffer.text, lines, chars = read_file(filename)

          statusbar.push(0, "File #{filename} : # lines #{lines}, # chars : #{chars}")
      end

      dialog.destroy
    end
    dialog.transient_for = window
    dialog.present
  end

  def read_file(filename : String) : {String, Int32, Int32}
    lines = File.read_lines(filename)
    s     = lines.join("\n")
    return s, lines.size, s.size
  end

  def bold_theme(window)
    text = "You clicked Bold"
    alert_dialog(window,text)
  end

  def dark_theme(window)
    text = "You clicked Prefer Dark Theme"
    alert_dialog(window,text)
  end

  def save_file_dialog(window)
    text = "You clicked Save"
    alert_dialog(window,text)
  end

  def saveas_file_dialog(window)
    text = "You clicked Save As"
    alert_dialog(window,text)
  end

  def logo_dialog(window)
    text = "You clicked Logo"
    alert_dialog(window,text)
  end

  def alert_dialog(window,text)
    ui      = get_message_dialog(text)
    builder = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    dialog  = Gtk::Dialog.cast(builder["alert_dialog"])
    dialog.transient_for = window

    button_close = Gtk::Button.cast(builder["button_close"])
    button_close.clicked_signal.connect do
      dialog.destroy
    end

    dialog.present
  end

  def help_about_dialog(window)
    Gtk.show_about_dialog(
      parent:         window,
      name:            "About Lesson001",
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

exit(Lesson001.new.run)
