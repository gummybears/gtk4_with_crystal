require "gtk4"

UI = <<-EOT
<interface>
  <object class="GtkDialog" id="root">
    <child internal-child="content_area">
      <object class="GtkBox">
        <child>
          <object class="GtkGLArea">
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
EOT

def activate(app : Gtk::Application)
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Gtk GLArea"
  window.set_default_size(200, 200)

  builder = Gtk::Builder.new_from_string(UI, UI.bytesize.to_i64)
  root = Gtk::Widget.cast(builder["root"])

  window.child = root
  window.present
end

app = Gtk::Application.new("hello.example.com", Gio::ApplicationFlags::None)
app.activate_signal.connect(->activate(Gtk::Application))
exit(app.run)
