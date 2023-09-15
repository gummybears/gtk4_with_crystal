def get_ui() : String

s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
 <menu id="menubar">
    <submenu>
      <attribute name="label">Menu</attribute>
      <section>
        <item>
          <attribute name="label">Fullscreen</attribute>
          <attribute name="action">win.fullscreen</attribute>
        </item>
      </section>
      <section>
        <attribute name="label">Color</attribute>
        <item>
          <attribute name="label">Red</attribute>
          <attribute name="action">app.color</attribute>
          <attribute name="target">red</attribute>
        </item>
        <item>
          <attribute name="label">Green</attribute>
          <attribute name="action">app.color</attribute>
          <attribute name="target">green</attribute>
        </item>
        <item>
          <attribute name="label">Blue</attribute>
          <attribute name="action">app.color</attribute>
          <attribute name="target">blue</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label" translatable="yes">_Quit</attribute>
          <attribute name="action">app.quit</attribute>
        </item>
      </section>
    </submenu>
  </menu>
</interface>
EOT
  return s
end
