#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"

class CssButton
  property widget : Gtk::Image

  def initialize(css_class : String)

    @widget = Gtk::Image.new
    @widget.set_size_request(48,32)
    @widget.add_css_class(css_class)

    # source = Gtk::DragSource.new()
    #g_signal_connect (source, "prepare", G_CALLBACK (css_drag_prepare), button);
    #gtk_widget_add_controller (button, GTK_EVENT_CONTROLLER (source));
  end
end


class ColorSwatch
  property widget : Gtk::Image
  #property color  : Gdk::RGBA

  def initialize(color : String)

    #provider = Gtk::CssProvider.new
    #Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,provider,0)

    # dummy = Gdk::RGBA.new(1.0,0.0,0.0,1.0)
    # if dummy.parse(color)
    #   #puts dummy.to_string
    # end
    # @color = dummy

    @widget = Gtk::Image.new
    @widget.set_size_request(48,32)
    @widget.add_css_class("bg_#{color}")

    ##new_css = sprintf(".bg { background-color: %s; }",dummy.to_string)
    ##puts "x #{new_css}"
    ##provider.load_from_data(new_css.to_slice)

    ##@widget.remove_css_class(".bg")
    #style_context = Gtk::StyleContext.new
    #style_context.remove_provider_from_display(Gdk::Display.default.not_nil!,provider)

    # works @widget = Gtk::ColorButton.new_with_rgba(dummy)
    # works @widget.show_editor = false
  end

  #def widget
  #  provider = Gtk::CssProvider.new
  #  Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,provider,0)
  #
  #  @widget.add_css_class("bg")
  #  new_css = sprintf(".bg { background-color: %s; }",@color.to_string)
  #  puts "css #{new_css}"
  #  provider.load_from_data(new_css.to_slice)
  #
  #  @widget
  #end

end

class Lesson013 < Gtk::Application

  def initialize()
    super(application_id: "drag_drop.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

  end

  @[GObject::Virtual]
  def activate

    provider = Gtk::CssProvider.new
    Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,provider,0)

    dir = Dir.current
    provider.load_from_path("#{dir}/dnd.css")

    window           = Gtk::Window.new()
    window.title     = "Drag and Drop"
    window.set_default_size(640,480)

    box = Gtk::Box.new(orientation: :vertical, spacing: 0)
    window.child = box

    box2 = Gtk::Box.new(orientation: :horizontal, spacing: 0)
    box.append(box2)

    #
    # Scrolled window
    #
    scrolled_window = Gtk::ScrolledWindow.new
    scrolled_window.set_policy(Gtk::PolicyType::Automatic,Gtk::PolicyType::Never)

    box.append(scrolled_window)

    box3 = Gtk::Box.new(orientation: :horizontal, spacing: 0)
    box3.add_css_class("linked")
    scrolled_window.child = box3

    colors = [
             "red", "green", "blue", "magenta", "orange", "gray", "black", "yellow",
             "white", "gray", "brown", "pink",  "cyan", "bisque", "gold", "maroon",
             "navy", "orchid", "olive", "peru", "salmon", "silver", "wheat"
             ]
    colors.each do |color|
      swatch = ColorSwatch.new(color)
      box3.append(swatch.widget)
    end

    swatch = CssButton.new("rainbow1")
    box3.append(swatch.widget)

    swatch = CssButton.new("rainbow2")
    box3.append(swatch.widget)

    swatch = CssButton.new("rainbow3")
    box3.append(swatch.widget)

    window.application = self
    window.present
  end
end

exit(Lesson013.new.run)
