#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"

class Lesson012 < Gtk::Application

  @@nr_times_dialog_is_shown : Int32 = 1

  def initialize()
    super(application_id: "dialogs.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate

    window = Gtk::Window.new()
    window.title     = "Dialogs"
    window.resizable = false

    #
    # vertical box
    #
    vbox = Gtk::Box.new(orientation: :vertical, spacing: 8)
    vbox.margin_start  = 8
    vbox.margin_end    = 8
    vbox.margin_top    = 8
    vbox.margin_bottom = 8

    #
    # Standard message dialog
    #
    hbox = Gtk::Box.new(orientation: :horizontal, spacing: 8)
    vbox.append(hbox)

    button = Gtk::Button.new_with_mnemonic ("_Message Dialog")
    button.clicked_signal.connect do
      message_dialog_clicked(window)
    end
    hbox.append(button)
    vbox.append(Gtk::Separator.new(orientation: :horizontal))

    #
    # Interactive dialog
    #
    hbox = Gtk::Box.new(orientation: :horizontal, spacing: 8)
    vbox.append(hbox)

    vbox2  = Gtk::Box.new(orientation: :vertical, spacing: 0)
    button_interactive = Gtk::Button.new_with_mnemonic ("_Interactive Dialog")
    hbox.append(vbox2)
    vbox2.append(button_interactive)

    table = Gtk::Grid.new
    table.row_spacing    = 4
    table.column_spacing = 4
    hbox.append(table)

    label1 = Gtk::Label.new_with_mnemonic("_Entry 1")
    column = 0
    row    = 0
    width  = 1
    height = 1
    table.attach(label1,column,row,width,height)

    entry1 = Gtk::Entry.new
    entry2 = Gtk::Entry.new

    column = 1
    row    = 0
    width  = 1
    height = 1
    table.attach(entry1,column,row,width,height)

    column = 1
    row    = 1
    width  = 1
    height = 1
    table.attach(entry2,column,row,width,height)

    label1.mnemonic_widget = entry1

    label2 = Gtk::Label.new_with_mnemonic("E_ntry 2")
    column = 0
    row    = 1
    width  = 1
    height = 1
    table.attach(label2,column,row,width,height)

    button_interactive.clicked_signal.connect do
      interactive_dialog_clicked(window,entry1,entry2)
    end

    window.child       = vbox
    window.application = self
    window.present
  end

  def message_dialog_clicked(window)
    dialog = Gtk::MessageDialog.new(
                                   buttons: Gtk::ButtonsType::OkCancel,
                                   text: "Test message",
                                   transient_for: window,
                                   destroy_with_parent: true,
                                   modal: true,
                                   )

    dialog.secondary_text = sprintf("Has been shown %d times",@@nr_times_dialog_is_shown)

    #
    # when the Cancel or Ok buttons are pressed
    # close the dialog
    #
    dialog.response_signal.connect do
      dialog.destroy
    end
    dialog.show

    @@nr_times_dialog_is_shown += 1
  end


  def interactive_dialog_clicked(window,entry1,entry2)
    dialog = Gtk::Dialog.new(
                            title: "Interactive Dialog",
                            transient_for: window,
                            destroy_with_parent: true,
                            modal: true,
                            use_header_bar: 1
                            )

    dialog.add_button("Cancel", Gtk::ResponseType::Cancel.value)
    dialog.add_button("OK",   Gtk::ResponseType::Accept.value)
    dialog.default_response = Gtk::ResponseType::Accept.value

    content_area = dialog.content_area

    table = Gtk::Grid.new
    table.hexpand = true
    table.vexpand = true
    table.halign  = Gtk::Align::Center
    table.valign  = Gtk::Align::Center

    content_area.append(table)
    table.row_spacing    = 6
    table.column_spacing = 6

    label1 = Gtk::Label.new_with_mnemonic("_Entry 1")
    table.attach(label1,0,0,1,1)

    local_entry1 = Gtk::Entry.new
    local_entry1.text = entry1.text
    table.attach(local_entry1,1,0,1,1)
    label1.mnemonic_widget = local_entry1

    label2 = Gtk::Label.new_with_mnemonic("E_ntry 2")
    table.attach(label2,0,1,1,1)

    local_entry2 = Gtk::Entry.new
    local_entry2.text = entry2.text
    table.attach(local_entry2,1,1,1,1)
    label2.mnemonic_widget = local_entry2


    #
    # response signals
    #
    dialog.response_signal.connect do |response|
      case Gtk::ResponseType.from_value(response)
        when .cancel?

        when .accept?
          if local_entry1.text != ""
            entry1.text = local_entry1.text
          end

          if local_entry2.text != ""
            entry2.text = local_entry2.text
          end
      end

      dialog.destroy
    end

    dialog.show
  end
end

exit(Lesson012.new.run)
