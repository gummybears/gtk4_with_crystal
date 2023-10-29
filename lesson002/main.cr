#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"

class Lesson002 < Gtk::Application

  def initialize()
    super(application_id: "assistant.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate
    create_assistant()
  end

  def entry_changed(assistant,entry)
    page_number  = 0
    current_page = assistant.nth_page(page_number)
    text         = entry.text

    if text
      assistant.set_page_complete(current_page.not_nil!,true)
    else
      assistant.set_page_complete(current_page.not_nil!,false)
    end
  end

  def create_page1(assistant)

    box = Gtk::Box.new(orientation: :horizontal, spacing: 12)
    box.margin_start  = 12
    box.margin_end    = 12
    box.margin_top    = 12
    box.margin_bottom = 12

    label = Gtk::Label.new("You must fill out this entry to continue:")
    box.append(label)

    entry = Gtk::Entry.new
    entry.activates_default = true
    entry.valign = :center
    box.append(entry)

    entry.changed_signal.connect do
      entry_changed(assistant,entry)
    end

    assistant.append_page(box)
    assistant.set_page_title(box,"Page 1")
    assistant.set_page_type(box,Gtk::AssistantPageType::Intro)
  end

  def create_page2(assistant)

    box = Gtk::Box.new(orientation: :horizontal, spacing: 12)
    box.margin_start  = 12
    box.margin_end    = 12
    box.margin_top    = 12
    box.margin_bottom = 12

    checkbutton = Gtk::CheckButton.new_with_label("This is optional data, you may continue even if you do not check this")
    checkbutton.valign = Gtk::Align::Center
    box.append(checkbutton)

    assistant.append_page(box)
    assistant.set_page_title(box,"Page 2")
    assistant.set_page_complete(box,true)
  end

  def create_page3(assistant)
    label = Gtk::Label.new("This is a confirmation page, press 'Apply' to apply changes")

    assistant.append_page(label)
    assistant.set_page_type(label,Gtk::AssistantPageType::Confirm)
    assistant.set_page_complete(label,true)
    assistant.set_page_title(label,"Confirmation")
  end

  def create_page4(assistant,progressbar)

    assistant.append_page(progressbar)
    assistant.set_page_type(progressbar,Gtk::AssistantPageType::Progress)
    assistant.set_page_title(progressbar,"Applying changes")

    #
    # This prevents the assistant window from being
    # closed while we're "busy" applying changes.
    #
    assistant.set_page_complete(progressbar,false)
  end

  def apply_changes_gradually(assistant,progressbar)

    fraction = progressbar.fraction()
    fraction += 0.1

    if fraction < 1.0
      progressbar.fraction = fraction
    else
      assistant.close
    end
  end

  def create_assistant()
    assistant = Gtk::Assistant.new
    assistant.set_default_size(-1,300)
    assistant.close_request_signal.connect do
      exit(0)
      true
    end

    progressbar              = Gtk::ProgressBar.new
    progressbar.halign       = Gtk::Align::Fill
    progressbar.valign       = Gtk::Align::Center
    progressbar.hexpand      = true
    progressbar.margin_start = 40
    progressbar.margin_end   = 40

    create_page1(assistant)
    create_page2(assistant)
    create_page3(assistant)
    create_page4(assistant,progressbar)

    assistant.cancel_signal.connect do
      assistant.close
    end

    assistant.close_signal.connect do
      assistant.close
    end

    assistant.apply_signal.connect do

      #
      # Start a timer to simulate changes taking a few seconds to apply.
      #
      priority = GLib::Priority::Default
      timespan = Time::Span.new(seconds: 1)
      GLib.timeout(timespan, priority) do
        apply_changes_gradually(assistant,progressbar)
        true
      end
    end

    assistant.visible     = true
    assistant.application = self
    assistant.present
  end
end

exit(Lesson002.new.run)
