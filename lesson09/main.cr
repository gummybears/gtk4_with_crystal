require "gtk4"

enum Color
  Red
  Green
  Blue
end

class App < Gtk::Application

  property fullscreen_state : Bool = false

  def initialize
    #
    # Note: Gio::ApplicationFlags::HandlesOpen is needed otherwise we get an error
    #
    super(application_id: "hello.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  def menubar1() : Gio::Menu

    #
    # Menu actions
    #
    action_quit = Gio::SimpleAction.new("quit",nil)
    # disable action_quit.activate_signal.connect(app_quit)
    self.add_action(action_quit)
    # not needed action_quit.enabled = true
    # xxxxx action_quit.activate_signal.connect(app_quit)

    #action_open = Gio::SimpleAction.new("open",nil)
    #action_open.activate_signal.connect(app_open)
    #self.add_action(action_open)

    #
    # Menubar
    #
    menubar = Gio::Menu.new
    menu_item_menu = Gio::MenuItem.new("File","app")

    # sub menu
    menu = Gio::Menu.new
    menu_item_connect = Gio::MenuItem.new("_Open", "app.open")
    menu_item_quit    = Gio::MenuItem.new("_Quit", "app.quit")

    menu.append_item(menu_item_connect)
    menu.append_item(menu_item_quit)

    # set submenu
    menu_item_menu.submenu = menu
    menubar.append_item(menu_item_menu)

    return menubar
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

  def color_activated(action : Gio::SimpleAction) #, parameter : GLib::Variant)
    new_color = "label.lb { background-color: green; }"
    provider  = Gtk::CssProvider.new
    provider.load_named(new_color,nil)
    #provider.load_from_file(css_file)

    action.state = "color::green"
  end

  def menubar2(window) : Gio::Menu

    #
    # Menu actions
    #

    #fullscreen_variant_type = GLib::VariantType.new("b")
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
    # the class is used by CSS Selector
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
    action_color.activate_signal.connect do
      color_activated(action_color)
      #->color_activated(Gio::SimpleAction)
    end
    add_action(action_color)

    #
    # Initialize the css data
    #
    provider = Gtk::CssProvider.new
    css_file = Gio::File.new_for_path("app.css")
    provider.load_from_file(css_file)
    #
    # Add CSS to the default GdkDisplay
    # priority = GTK_STYLE_PROVIDER_PRIORITY_APPLICATION)
    #
    Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,provider,0)

    #
    # attach menubar to application's menubar
    #
    self.menubar = menubar2(window)
    window.show_menubar = true
    window.present
  end
end

exit(App.new.run)
