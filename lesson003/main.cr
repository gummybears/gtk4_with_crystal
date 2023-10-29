#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

class Lesson003 < Gtk::Application

  property provider : Gtk::CssProvider
  property time2    : UInt64 = 0

  def initialize()
    super(application_id: "colors.example.com", flags: Gio::ApplicationFlags::HandlesOpen)

    @provider = Gtk::CssProvider.new
  end

  @[GObject::Virtual]
  def activate
    ui       = get_ui()
    builder  = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window   = Gtk::Window.cast(builder["window"])
    label    = Gtk::Label.cast(builder["fps"])
    box      = Gtk::Box.cast(builder["box"])

    priority = GLib::Priority::Default
    timespan = Time::Span.new(nanoseconds: 100_000_000)
    GLib.timeout(timespan, priority) do
      update_fps_label(label)
      true
    end

    @provider = Gtk::CssProvider.new
    Gtk::StyleContext.add_provider_for_display(Gdk::Display.default.not_nil!,@provider,0)

    new_color = "rgba(255,0,0,0)"
    box.add_css_class("bg")

    new_css   = sprintf("box.bg { background-color: %s; }",new_color)
    @provider.load_from_data(new_css.to_slice)

    window.child = box
    tick_back = box.add_tick_callback(->change_color(Gtk::Widget, Gdk::FrameClock))

    #
    # important to set the window application to self
    #
    window.application = self
    window.present
  end

  def update_fps_label(label)
    frame_clock = label.frame_clock()
    if frame_clock
      get_fps    = frame_clock.fps()
      fps        = sprintf("%.2f fps", get_fps)
      label.text = fps

      @time2     = frame_clock.frame_time.to_u64

    else
      label.text = ""
    end
  end

  def change_color(box,frameclock)
    red       = rand(255)
    green     = rand(255)
    blue      = rand(255)
    new_color = sprintf("rgba(%s,%s,%s,1.0)",red.to_s(10), green.to_s(10), blue.to_s(10))
    new_css   = sprintf("box.bg { background-color: %s; }",new_color)
    @provider.load_from_data(new_css.to_slice)

    time = frameclock.frame_time.to_u64
    if (time >= @time2)
      @time2 = time + 15
      box.queue_draw
    end

    true
  end
end

exit(Lesson003.new.run)
