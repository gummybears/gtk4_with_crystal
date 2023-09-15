require "gtk4"

class App < Gtk::Application

  property fullscreen_state : Bool = false
  property provider         : Gtk::CssProvider

  def initialize
    #
    # Note: Gio::ApplicationFlags::HandlesOpen is needed otherwise we get an error
    #
    super(application_id: "hello.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

    #
    # not sure this is the correct way
    # something to do with the garbage collector
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
    # but unsure how to do that
    #
    # the C code uses  gtk_css_provider_load_from_data (provider, new_css, -1)
    # and looking at class Gtk::Provider there is a method load_from_data
    # which accepts an Enumerable(UInt8) as data
    #
    #@provider.load_from_data(new_css)

    #
    # I am using the css files here but
    # load_from_data should be used
    #
    css_file = Gio::File.new_for_path("#{new_color}.css")
    @provider.load_from_file(css_file)


    #
    # set menu item state
    #
    action.state = parameter
  end

  def menubar(window) : Gio::Menu

    #
    # Menu actions
    #
    action_fullscreen = Gio::SimpleAction.new_stateful("fullscreen",nil, false)
    action_fullscreen.change_state_signal.connect do
      fullscreen_changed(window,action_fullscreen)
    end

    window.add_action(action_fullscreen)

    #
    # Menubar
    #
    menubar  = Gio::Menu.new
    menu     = Gio::Menu.new
    section1 = Gio::Menu.new
    section2 = Gio::Menu.new
    section3 = Gio::Menu.new

    menu_item_fullscreen = Gio::MenuItem.new("Full Screen", "win.fullscreen")
    menu_item_red        = Gio::MenuItem.new("Red",         "app.color::red")
    menu_item_green      = Gio::MenuItem.new("Green",       "app.color::green")
    menu_item_blue       = Gio::MenuItem.new("Blue",        "app.color::blue")
    menu_item_quit       = Gio::MenuItem.new("Quit",        "app.quit")

    section1.append_item(menu_item_fullscreen)
    section2.append_item(menu_item_red)
    section2.append_item(menu_item_green)
    section2.append_item(menu_item_blue)
    section3.append_item(menu_item_quit)

    menu.append_section(nil,section1)
    menu.append_section("Color",section2)
    menu.append_section(nil,section3)
    menubar.append_submenu("Menu",menu)

    return menubar
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
    # add action to menu item Quit
    #
    action_quit = Gio::SimpleAction.new("quit",nil)
    action_quit.activate_signal.connect do
      quit_application()
    end
    add_action(action_quit)

    #
    # add action to sub menu Color
    #
    # taken from https://toshiocp.github.io/Gtk4-tutorial/sec18.html
    # parameter "b" means boolean type.
    # parameter "s means string type.
    #
    color_variant_type = GLib::VariantType.new("s")
    action_color = Gio::SimpleAction.new_stateful("color", color_variant_type, "red")
    action_color.activate_signal.connect(->color_activated(Gio::SimpleAction, GLib::Variant))
    add_action(action_color)

    #
    # Initialize the css data
    #
    css_file = Gio::File.new_for_path("red.css")
    @provider.load_from_file(css_file)

    #
    # Add CSS to the default GdkDisplay
    # priority = GTK_STYLE_PROVIDER_PRIORITY_APPLICATION)
    #
    Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,@provider,0)

    #
    # attach menubar to application's menubar
    #
    self.menubar = menubar(window)
    window.show_menubar = true
    window.present
  end
end

exit(App.new.run)
