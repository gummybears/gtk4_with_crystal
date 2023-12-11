#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

#const GDK_TYPE_TEXTURE 94320186442928
#const GDK_TYPE_PAINTABLE 94320186443200
#const GDK_TYPE_RGBA 94320186444528
#const G_TYPE_FILE 94320186444816

GDK_TYPE_TEXTURE   = 94320186442928.to_u64
GDK_TYPE_PAINTABLE = 94320186443200.to_u64
GDK_TYPE_RGBA      = 94320186444528.to_u64
G_TYPE_FILE        = 94320186444816.to_u64

class Lesson005 < Gtk::Application
  include Gio::AsyncResult

  def initialize()
    super(application_id: "clipboard.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate
    ui          = get_ui()
    builder     = Gtk::Builder.new_from_string(ui, ui.bytesize.to_i64)
    window      = Gtk::Window.cast(builder["window"])

    text_entry  = Gtk::Entry.cast(builder["source_text"])
    text_entry.changed_signal.connect do
      text_entry_changed(text_entry)
    end

    source_file  = Gtk::Button.cast(builder["source_file"])
    source_color = Gtk::ColorButton.cast(builder["source_color"])
    copy_button  = Gtk::Button.cast(builder["copy_button"])
    paste_button = Gtk::Button.cast(builder["paste_button"])
    combobox     = Gtk::DropDown.cast(builder["source_chooser"])

    source_stack = Gtk::Stack.cast(builder["source_stack"])
    dest_stack   = Gtk::Stack.cast(builder["dest_stack"])


    source_clipboard   = source_stack.clipboard
    visible_child_name = ""

    copy_button.clicked_signal.connect do

      visible_child      = source_stack.visible_child
      visible_child_name = source_stack.visible_child_name

      puts "visible child class #{visible_child.class} name #{visible_child_name}"

      case visible_child_name
        when "Text"
          text = visible_child.as(Gtk::Editable).text
          source_clipboard.set(text)

        when "Color"
          color = source_color.rgba

          puts "lesson005: setting clipboard RBBA not implemented"
          # source_clipboard.set(color)

        when "Image"

          children = visible_child.not_nil!.children
          #puts "nr children #{children.size}"

          xxxx = visible_child.not_nil!.first_child
          puts "first class #{xxxx.class} name #{xxxx.not_nil!.name}"
          #b = xxxx.as(Gtk::ToggleButton)
          #puts "button #{b.name}"

          children.each do |c|
            puts "c class #{c.class} name #{c.not_nil!.name}" # id #{child.not_nil!.id}"

            name  = c.not_nil!.name
            case name
              when "GtkToggleButton"
                #b = c.not_nil!.next_sibling.as(Gtk::ToggleButton)
                #puts "b name #{b.name}"
                #image = b.next_sibling.not_nil!

                puts "xxx #{c.class} n #{c.not_nil!.name}"
                puts "nr sub children #{c.not_nil!.children.size}"

                c.not_nil!.children.each do |x|
                  puts "x class #{x.class} name #{x.not_nil!.name}"
                end
                # if b.not_nil!.active

                #   image = child.not_nil!.first_child
                #   paintable = image.as(Gtk::Image)
                # end
            end

          end

          #child = visible_child.not_nil!.first_child
          ##puts "c class #{child.class} name #{child.not_nil!.name}" # id #{child.not_nil!.id}"
          #name  = child.not_nil!.name
          #case name
          #  when "GtkToggleButton"
          #    puts "here"
          #    # b = child.as(Gtk::ToggleButton)
          #    # if b.not_nil!.active
          #    #   image = child.not_nil!.first_child
          #    #   paintable = image.as(Gtk::Image)
          #    # end
          #end
          #

          #if child.as(Gtk::ToggleButton).active
          #end

          #for (child = gtk_widget_get_first_child (visible_child); child; child = gtk_widget_get_next_sibling (child))
          #{
            #if (gtk_toggle_button_get_active (GTK_TOGGLE_BUTTON (child)))
              #{
                #GtkWidget *image = gtk_widget_get_first_child (child);
                #GdkPaintable *paintable = gtk_image_get_paintable (GTK_IMAGE (image));
  #
                #if (GDK_IS_TEXTURE (paintable))
                  #gdk_clipboard_set (clipboard, GDK_TYPE_TEXTURE, paintable);
                #else
                  #gdk_clipboard_set (clipboard, GDK_TYPE_PAINTABLE, paintable);
                #break;
              #}
          #}

        when "File"
      end
    end

    paste_button.clicked_signal.connect do
      puts "1"
      dest_clipboard = dest_stack.clipboard
      formats        = dest_clipboard.formats
      puts "formats #{formats.to_string}"
      puts "mine type #{formats.mime_types}"
      # gtype     = formats.contain_gtype(Gdk::String)

      puts "2"

      #if (gdk_content_formats_contain_gtype (formats, GDK_TYPE_TEXTURE))
      # gdk_clipboard_read_value_async (clipboard, GDK_TYPE_TEXTURE, 0, NULL, paste_received, dest_stack);
      #else if (gdk_content_formats_contain_gtype (formats, GDK_TYPE_PAINTABLE))
      # gdk_clipboard_read_value_async (clipboard, GDK_TYPE_PAINTABLE, 0, NULL, paste_received, dest_stack);
      #else if (gdk_content_formats_contain_gtype (formats, GDK_TYPE_RGBA))
      # gdk_clipboard_read_value_async (clipboard, GDK_TYPE_RGBA, 0, NULL, paste_received, dest_stack);
      #else if (gdk_content_formats_contain_gtype (formats, G_TYPE_FILE))
      # gdk_clipboard_read_value_async (clipboard, G_TYPE_FILE, 0, NULL, paste_received, dest_stack);
      #else if (gdk_content_formats_contain_gtype (formats, G_TYPE_STRING))
      # gdk_clipboard_read_value_async (clipboard, G_TYPE_STRING, 0, NULL, paste_received, dest_stack);

      if formats.contain_gtype(GDK_TYPE_TEXTURE)
        puts "texture"
      elsif formats.contain_gtype(GDK_TYPE_PAINTABLE)
        puts "paintable"
      elsif formats.contain_gtype(GDK_TYPE_RGBA)
        puts "rgba"
      elsif formats.contain_gtype(G_TYPE_FILE)
        puts "file"
      elsif formats.contain_gtype(GObject::TYPE_STRING)
        puts "string"
      end

      # todo case visible_child_name
      # todo   when "Text"
      # todo         puts "3"
      # todo
      # todo     result = Gio::SimpleAsyncResult.new
      # todo    puts "4"
      # todo
      # todo     value  = source_clipboard.read_value_finish(result)
      # todo     if value
      # todo       dest_stack.visible_child_name = "Text"
      # todo       child = dest_stack.visible_child
      # todo
      # todo       # return the value of type GObject::Value as a string
      # todo       child.as(Gtk::Label).text = value.as_s
      # todo     end
      # todo end
    end

    window.application = self
    window.present
  end

  def text_entry_changed(entry)
    puts "x"
  end

  def close_window(window)
    window.close
  end
end

exit(Lesson005.new.run)
