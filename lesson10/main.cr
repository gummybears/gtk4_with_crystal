require "gtk4"

require "./ui.cr"

class App < Gtk::Application

  property fullscreen_state : Bool = false
  property provider         : Gtk::CssProvider

  def initialize

    super(application_id: "hello.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

    #
    # not sure this is the correct way
    # has to do with the garbage collector
    #
    @provider = Gtk::CssProvider.new
  end

  def fullscreen_changed(window,action)
    if @fullscreen_state
      window.unmaximize
    else
      window.maximize
    end

    @fullscreen_state = !@fullscreen_state
    action.state = @fullscreen_state
  end

  def quit_application
    exit()
  end

  def color_activated(action : Gio::SimpleAction, parameter : GLib::Variant)

    new_color = parameter.to_s
    #
    # remove single quotes
    #
    new_color = new_color.gsub(/\'/,"")
    new_css   = sprintf("label.lb { background-color: %s; }",new_color)

    #
    # need to update the css for the label
    #
    @provider.load_from_data(new_css.to_slice)

    #
    # set menu item state
    #
    action.state = parameter
  end

  def menu_accelerators()
    set_accels_for_action("app.quit",         ["<Ctrl>Q"])
    set_accels_for_action("win.fullscreen",   ["<Ctrl>F"])
    set_accels_for_action("app.color::red",   ["<Ctrl>R"])
    set_accels_for_action("app.color::green", ["<Ctrl>G"])
    set_accels_for_action("app.color::blue",  ["<Ctrl>B"])
  end

  def menu_actions(window)
    action_quit = Gio::SimpleAction.new("quit",nil)
    action_quit.activate_signal.connect do
      quit_application()
    end

    add_action(action_quit)

    color_variant_type = GLib::VariantType.new("s")
    action_color = Gio::SimpleAction.new_stateful("color", color_variant_type, "red")
    action_color.activate_signal.connect(->color_activated(Gio::SimpleAction, GLib::Variant))
    add_action(action_color)

    action_fullscreen = Gio::SimpleAction.new_stateful("fullscreen",nil, false)
    action_fullscreen.change_state_signal.connect do
      fullscreen_changed(window,action_fullscreen)
    end

    window.add_action(action_fullscreen)
  end

  @[GObject::Virtual]
  def activate
    window       = Gtk::ApplicationWindow.new(self)
    window.title = "Menubar and menu items"
    window.set_default_size(400, 300)

    #
    # create dummy label
    #
    label = Gtk::Label.new
    #
    # the class is used by the CSS Selector
    #
    label.add_css_class("lb")
    window.child = label

    #
    # Menu bar from get_ui()
    #
    ui      = get_ui()
    builder = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    menubar = Gio::Menu.cast(builder["menubar"])

    #
    # Menu actions
    #
    menu_actions(window)

    #
    # Menu accelarators
    #
    menu_accelerators()

    #
    # Initialize the css data
    #
    filename = "app.css"
    if File.exists?(filename)
      css_file = Gio::File.new_for_path("app.css")
      @provider.load_from_file(css_file)
    else
      puts "file #{filename} not found, exit"
      exit(0)
    end

    #
    # Add CSS to the default GdkDisplay
    # priority = GTK_STYLE_PROVIDER_PRIORITY_APPLICATION)
    #
    Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,@provider,0)

    #
    # attach menubar to application's menubar
    #
    self.menubar = menubar
    window.show_menubar = true
    window.present
  end
end

exit(App.new.run)
