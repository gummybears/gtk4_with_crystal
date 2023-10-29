require "./ui.cr"

class AlertDialog < Gtk::Window
  property filename : String
  property basename : String
  property modified : Bool = false
  property window   : Gtk::ApplicationWindow

  def initialize(application,window,filename : String)
    @filename = filename

    if @filename =~ /untitled/
      @basename = @filename
    else
      @basename = File.basename(filename)
    end
    @window = window
  end

  def present(callback1,callback2,callback3)
    ui       = get_alert_dialog(@filename)
    builder  = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    dialog   = Gtk::Dialog.cast(builder["alert_dialog"])
    dialog.transient_for = @window

    button_cancel = Gtk::Button.cast(builder["button_cancel"])
    button_dont   = Gtk::Button.cast(builder["button_dont"])
    button_save   = Gtk::Button.cast(builder["button_save"])

    button_cancel.clicked_signal.connect do
      puts "button cancel clicked"
      dialog.close()
    end

    button_dont.clicked_signal.connect do
      puts "button dont save clicked"
      dialog.close()
    end

    button_save.clicked_signal.connect do
      puts "button save clicked"
      dialog.close()
      callback3.call(@filename)
    end

    dialog.present
  end
end
