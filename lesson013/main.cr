#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"

class CssButton < Gtk::Widget
  #property parent : Gtk::Widget
  property button : Gtk::Image

  def initialize(css_class : String)
    super()
    #@parent = parent

    @button = Gtk::Image.new
    @button.set_size_request(48,32)
    @button.add_css_class(css_class)

    # source = Gtk::DragSource.new()
    #g_signal_connect (source, "prepare", G_CALLBACK (css_drag_prepare), button);
    #gtk_widget_add_controller (button, GTK_EVENT_CONTROLLER (source));
  end

end

class ColorSwatch < Gtk::Widget

  property parent : Gtk::Widget
  property color  : Gdk::RGBA

  def initialize(parent,color : String)
    super()

    @parent = parent
    dummy   = Gdk::RGBA.new(1.0,0.0,1.0,0.0)
    @color  = dummy #.parse(color)

    css_name = "colorswatch"
  end
end

class CanvasItem < Gtk::Widget
  property parent : Gtk::Widget
  property fixed  : Gtk::Fixed
  property label  : Gtk::Label
  property editor : Gtk::Widget|Nil

  property radius : Float64 = 0.0
  property angle  : Float64 = 0.0
  property delta  : Float64 = 0.0

  def initialize(parent,text : String, id : Int32)

    super()

    @parent = parent
    @editor = nil

    s = sprintf("Item %d",id)
    @label = Gtk::Label.new(s)
    @label.add_css_class("canvasitem")

    @fixed = Gtk::Fixed.new()
    @fixed.parent = parent
    @fixed.put(@label,0,0)

    @label.add_css_class("frame")
    @label.name = id.to_s
#
#  if (theme_is_dark ())
#    gdk_rgba_parse (&rgba, "blue");
#  else
#    gdk_rgba_parse (&rgba, "yellow");
#
#  set_color (item, &rgba);
#
#  item->angle = 0;
#
#  dest = gtk_drop_target_new (G_TYPE_INVALID, GDK_ACTION_COPY);
#  gtk_drop_target_set_gtypes (dest, types, G_N_ELEMENTS (types));
#  g_signal_connect (dest, "drop", G_CALLBACK (item_drag_drop), NULL);
#  gtk_widget_add_controller (GTK_WIDGET (item->label), GTK_EVENT_CONTROLLER (dest));
#
#  gesture = gtk_gesture_rotate_new ();
#  g_signal_connect (gesture, "angle-changed", G_CALLBACK (angle_changed), NULL);
#  g_signal_connect (gesture, "end", G_CALLBACK (rotate_done), NULL);
#  gtk_widget_add_controller (GTK_WIDGET (item), GTK_EVENT_CONTROLLER (gesture));
#
#  gesture = gtk_gesture_click_new ();
#  g_signal_connect (gesture, "released", G_CALLBACK (click_done), NULL);
#  gtk_widget_add_controller (GTK_WIDGET (item), GTK_EVENT_CONTROLLER (gesture));

  end

  def apply_transform()
    x = @label.allocated_width/2.0
    y = @label.allocated_height/2.0

    puts "x #{x} y #{y}"
    @radius = Math.sqrt(x*x + y*y)

    transform = Gsk::Transform.new(Pointer(Void).malloc(1),GICrystal::Transfer::None)

    point     = Graphene::Point.new(@radius.to_f32,@radius.to_f32)
    transform.translate(point)

    transform.rotate((@angle + @delta).to_f32)

    point     = Graphene::Point.new(-x.to_f32,-y.to_f32)
    transform.translate(point)


    @fixed.set_child_transform(@label,transform)
  end

end

class Lesson013 < Gtk::Application

  #property provider : Gtk::CssProvider
  #property canvas   : Gtk::Fixed

  def initialize()
    super(application_id: "drag_drop.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

    #@provider = Gtk::CssProvider.new
    #@canvas   = Gtk::Fixed.new
  end

  @[GObject::Virtual]
  def activate

    provider = Gtk::CssProvider.new

    dir = Dir.current
    provider.load_from_path("#{dir}/dnd.css")
    #
    # gtk_style_context_add_provider_for_display (gdk_display_get_default (),
    #                                              GTK_STYLE_PROVIDER (provider),
    #                                              800);

    #button           = Gtk::ColorButton.new
    window           = Gtk::Window.new()
    window.title     = "Drag and Drop"
    window.set_default_size(640,480)

    box = Gtk::Box.new(orientation: :vertical, spacing: 0)
    window.child = box

    box2 = Gtk::Box.new(orientation: :horizontal, spacing: 0)
    box.append(box2)

    canvas = canvas_new()
    box2.append(canvas)

    nr_items = 0
    x        = 40
    y        = 40
    (0..3).each do |i|

      item = CanvasItem.new(canvas,"Item",i+1)
      canvas.put(item,x,y)
      item.apply_transform()

      puts "x #{x} y #{y}"

      x += 150
      y += 100
    end

    box.append(Gtk::Separator.new(orientation: :horizontal))


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
      swatch = ColorSwatch.new(canvas,color)
      box3.append(swatch)
    end

    image = CssButton.new("rainbow1")
    box3.append(image)

    image = CssButton.new("rainbow2")
    box3.append(image)

    image = CssButton.new("rainbow3")
    box3.append(image)

    window.application = self
    window.present
  end

  def canvas_new()
    canvas         = Gtk::Fixed.new
    canvas.hexpand = true
    canvas.vexpand = true

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

  # todo
  # todo def drag_prepare_callback(x : Float64, y : Float64)
  # todo   canvas = source.widget
  # todo   #gtk_event_controller_get_widget (GTK_EVENT_CONTROLLER (source));
  # todo   item = canvas.pick(x,y,Gtk::PickFlags::Default)
  # todo
  # todo   item2 = item.ancestor
  # todo   #item = gtk_widget_get_ancestor (item, canvas_item_get_type ());
  # todo   #if (!item)
  # todo     #return NULL;
  # todo   #g_object_set_data (G_OBJECT (canvas), "dragged-item", item);
  # todo
  # todo   return Gdk::ContentProvider.new #(item)
  # todo end


#  g_signal_connect (source, "prepare", G_CALLBACK (prepare), NULL);
#  g_signal_connect (source, "drag-begin", G_CALLBACK (drag_begin), NULL);
#  g_signal_connect (source, "drag-end", G_CALLBACK (drag_end), NULL);
#  g_signal_connect (source, "drag-cancel", G_CALLBACK (drag_cancel), NULL);
#  gtk_widget_add_controller (canvas, GTK_EVENT_CONTROLLER (source));
#
#  dest = gtk_drop_target_new (GTK_TYPE_WIDGET, GDK_ACTION_MOVE);
#  g_signal_connect (dest, "drop", G_CALLBACK (drag_drop), NULL);
#  gtk_widget_add_controller (canvas, GTK_EVENT_CONTROLLER (dest));
#
#  gesture = gtk_gesture_click_new ();
#  gtk_gesture_single_set_button (GTK_GESTURE_SINGLE (gesture), 0);
#  g_signal_connect (gesture, "pressed", G_CALLBACK (pressed_cb), NULL);
#  g_signal_connect (gesture, "released", G_CALLBACK (released_cb), NULL);
#  gtk_widget_add_controller (canvas, GTK_EVENT_CONTROLLER (gesture));
#
#  return canvas;

end

exit(Lesson013.new.run)
