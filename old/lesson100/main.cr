require "gtk4"

@[Gtk::UiTemplate(file: "#{__DIR__}/application.ui")] #, children: %w(label))]
class ExampleAppWindow < Gtk::ApplicationWindow
  include Gtk::WidgetTemplate

  def initialize
    super()
  end
end

app = Gtk::Application.new("lesson01.example.com", Gio::ApplicationFlags::None)
app.activate_signal.connect do
  window = ExampleAppWindow.new
  window.application = app
  window.present

  builder = Gtk::Builder.new_from_file("#{__DIR__}/menu.ui")
  app.menubar = Gio::MenuModel.cast(builder["menubar"])
end

exit(app.run)
