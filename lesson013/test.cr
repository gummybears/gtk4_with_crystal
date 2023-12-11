#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"

class CanvasItem

  property widget : Gtk::Box
  property parent : Gtk::Widget
  property id     : Int32 = 0
  #property text   : String = ""
  property fixed  : Gtk::Fixed
  property label  : Gtk::Label

  property radius : Float64 = 0.0
  property angle  : Float64 = 0.0
  property delta  : Float64 = 0.0

  property dest   : Gtk::DropTarget

  def initialize(parent, id : Int32)

    @parent = parent

    text = sprintf("Item %d",id)
    @label = Gtk::Label.new(text)
    @label.add_css_class("canvasitem")

    @fixed = Gtk::Fixed.new()
    @fixed.width_request  = 40
    @fixed.height_request = 20
    #@fixed.parent = parent

    @widget = Gtk::Box.new(orientation: :vertical, spacing: 0)
    @widget.parent = parent

    puts "fixed w #{@fixed.width} h #{@fixed.height}"

    @fixed.put(@label,0,0)
    @label.add_css_class("frame")
    @label.name = id.to_s

    dummy = Gdk::RGBA.new(1.0,0.0,0.0,1.0)
    color = "yellow"
    if dummy.parse(color)
      #puts dummy.to_string
    end

    set_color(dummy)

    @dest = Gtk::DropTarget.new #gtk_drop_target_new (G_TYPE_INVALID, GDK_ACTION_COPY);
    #gtk_drop_target_set_gtypes (dest, types, G_N_ELEMENTS (types));
    @dest.drop_signal.connect ->item_drag_drop(GObject::Value,Float64,Float64)
     #g_signal_connect (dest, "drop", G_CALLBACK (item_drag_drop), NULL);
    #@label.add_controller(@dest)
    @widget.add_controller(@dest)
    @widget.append(@fixed)
    @widget.append(@label)
  end

  def set_color(color : Gdk::RGBA)
    #@fixed.add_css_class("bg_yellow")
    @widget.add_css_class("bg_yellow")
  end

  def item_drag_drop(value : GObject::Value, x : Float64, y : Float64) #(value,x,y)
    puts "x #{x} y #{y}"

    #label = dest.as(Gtk::EventController).get_widget
    #GtkWidget *label = gtk_event_controller_get_widget (GTK_EVENT_CONTROLLER (dest));
    #CanvasItem *item = CANVAS_ITEM (gtk_widget_get_parent (gtk_widget_get_parent (label)));
    #
    #if (G_VALUE_TYPE (value) == GDK_TYPE_RGBA)
      #set_color (item, g_value_get_boxed (value));
    #else if (G_VALUE_TYPE (value) == G_TYPE_STRING)
      #set_css (item, g_value_get_string (value));

    return true
  end


end

class CssButton
  property widget    : Gtk::Image
  property source    : Gtk::DragSource
  property css_class : String = ""

  def initialize(css_class : String)

    @css_class = css_class
    @widget    = Gtk::Image.new
    @widget.set_size_request(48,32)
    @widget.add_css_class(css_class)

    @source = Gtk::DragSource.new()
    #@source.prepare_signal.connect ->drag_prepare(Float64,Float64)
    #@source.drag_begin_signal.connect(->drag_begin_callback(Float64,Float64))
    #@source.drag_update_signal.connect(->drag_update_callback(Float64,Float64))
    #@source.drag_end_signal.connect(->drag_begin_callback(Float64,Float64))

    @widget.add_controller(@source)

  end

  #def drag_prepare(x : Float64, y : Float64) : Gdk::ContentProvider
  #  puts "x #{x} y #{y}"
  #
  #  puts "1"
  #  paintable = Gtk::WidgetPaintable.new(@widget)
  #  puts "2"
  #  @source.set_icon(paintable, 0, 0)
  #  puts "3"
  #  return Gdk::ContentProvider.new() #_typed("css-class")
  #end
  #
  #
  #def drag_begin_callback(x : Float64, y : Float64)
  #  #puts "drag begin : x #{x} y #{y}"
  #  @x = x
  #  @y = y
  #end
  #
  #def drag_update_callback(x : Float64, y : Float64)
  #  #puts "drag update : x #{x} y #{y}"
  #  @offset_x = x
  #  @offset_y = y
  #  #@x     = x
  #  #@y     = y
  #  layout = @manager
  #
  #  #@parent.queue_allocate
  #end
  #
  #def drag_end_callback(x : Float64, y : Float64)
  #  #puts "drag end : x #{x} y #{y}"
  #  @x = x
  #  @y = y
  #end

end


class ColorSwatch
  property widget : Gtk::Image

  def initialize(color : String)

    @widget = Gtk::Image.new
    @widget.set_size_request(48,32)
    @widget.add_css_class("bg_#{color}")
  end
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

    # window.width_request  = 640
    # window.height_request = 480

    box = Gtk::Box.new(orientation: :vertical, spacing: 0)
    window.child = box

    box2 = Gtk::Box.new(orientation: :horizontal, spacing: 0)
    box.append(box2)

    dim("window",window)
    dim("box",box)
    dim("box2",box2)

    canvas = canvas_new()
    box2.append(canvas)

    #
    # Canvas Items
    #
    canvas_items(canvas)
    box.append(Gtk::Separator.new(orientation: :horizontal))

    #
    # Scrolled window
    #
    scrolled_window_colors(box)

    window.application = self
    window.present
  end

  def dim(text,widget)
    puts "#{text} w #{widget.allocated_width} h #{widget.allocated_height}"
    puts "#{text} w #{widget.width} h #{widget.height}"
  end

  def canvas_new()
    canvas         = Gtk::Fixed.new
    canvas.hexpand = true
    canvas.vexpand = true

    #x = canvas.measure(orientation: :vertical, for_size: 0)
    #puts "x #{x.class}"

    dim("canvas",canvas)

    source = Gtk::DragSource.new()
    dest   = Gtk::DropTarget.new()

    source.actions = Gdk::DragAction::Move

    #source.prepare_signal.connect(->drag_prepare_callback(Float64,Float64))
    #source.drag_begin_signal.connect(->drag_begin_callback(Float64,Float64))
    #source.drag_cancel_signal.connect(->drag_cancel_callback(Float64,Float64))
    #source.drag_end_signal.connect(->drag_begin_callback(Float64,Float64))

    # ??? canvas.add_controller = source.as(Gtk::EventController)
    return canvas
  end

  def canvas_items(canvas)

    nr_items = 0
    x        = 40.0
    y        = 40.0
    (0..3).each do |i|

      item = CanvasItem.new(canvas,i+1)
      puts "xxx"
      #canvas.put(item.parent,x,y)
      canvas.put(item.widget,x,y)
      #item.apply_transform()

      puts "x #{x} y #{y}"

      x += 150
      y += 100
    end

  end

  def scrolled_window_colors(box)
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
  end
end

exit(Lesson013.new.run)
