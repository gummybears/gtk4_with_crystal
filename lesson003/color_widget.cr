#
# color_widget.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#

#
# Not used, perhaps in the future
#
class ColorWidget < Gtk::Widget

  property parent   : Gtk::Widget
  property color1   : Gdk::RGBA = Gdk::RGBA.new(0.0,0.0,0.0,0.0)
  property color2   : Gdk::RGBA = Gdk::RGBA.new(0.0,0.0,0.0,0.0)
  property time2    : UInt64  = 0
  property t        : Float64 = 0.0
  property snapshot : Gtk::Snapshot

  def initialize(parent : Gtk::Widget)
    @parent   = parent
    @snapshot = Gtk::Snapshot.new
    hexpand   = true
    vexpand   = true

    snapshot = color_snapshot
  end

  def change_color()

    time     = @parent.frameclock.frame_time
    timespan = Time.span(3)
    if (time >= @time2)
        @time2        = time + timespan
        @color1       = @color2
        @color2.red   = rand(1.0)
        @color2.green = rand(1.0)
        @color2.blue  = rand(1.0)
        @color2.alpha = 1.0
    end

    t = 1.0 - (@time2 - time)/timespan
    queue_draw
  end

  def color_snapshot()

    w     = @parent.width.to_f32
    h     = @parent.height.to_f32
    c     = Gdk::RGBA.new(0_f32,0_f32,0_f32,0_f32) #,0_f32)
    red   = (1.0 - t) * @color1.red   + @t * @color2.red
    green = (1.0 - t) * @color1.green + @t * @color2.green
    blue  = (1.0 - t) * @color1.blue  + @t * @color2.blue
    alpha = 1.0

    @snapshot.append_color(c,0_f32,0_f32,w,h)
  end
end
