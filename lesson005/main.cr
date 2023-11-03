#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"
require "./ui.cr"

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

      case visible_child_name
        when "Text"

          text = visible_child.as(Gtk::Editable).text
          puts "text #{text}"
          source_clipboard.set(text)

        when "Color"
        when "Image"
        when "File"
      end
    end

    paste_button.clicked_signal.connect do
      dest_clipboard = dest_stack.clipboard
      # formats   = clipboard.formats
      # gtype     = formats.contain_gtype(Gdk::String)

      case visible_child_name
        when "Text"
          result = Gio::SimpleAsyncResult.new
          value  = source_clipboard.read_value_finish(result)
          if value
            dest_stack.visible_child_name = "Text"
            child = dest_stack.visible_child

            # return the value of type GObject::Value as a string
            child.as(Gtk::Label).text = value.as_s
          end
      end
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
