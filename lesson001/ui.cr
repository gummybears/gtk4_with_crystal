def get_ui() : String
  s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkApplicationWindow" id="window">
    <property name="title" translatable="yes">Lesson001 : Application Class</property>
    <property name="default-width">200</property>
    <property name="default-height">200</property>
    <property name="icon-name">document-open</property>
    <child>
      <object class="GtkGrid">
        <child>
          <object class="GtkBox">
            <property name="hexpand">1</property>
            <child>
              <object class="GtkMenuButton" id="menubutton">
                <property name="icon-name">document-open</property>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="icon-name">application-exit</property>
                <property name="action-name">app.quit</property>
              </object>
            </child>
            <child>
              <object class="GtkSeparator"/>
            </child>
            <child>
              <object class="GtkButton">
                <property name="icon-name">applications-other</property>
                <property name="action-name">app.logo</property>
              </object>
            </child>
            <layout>
              <property name="column">0</property>
              <property name="row">0</property>
            </layout>
          </object>
        </child>
        <child>
          <object class="GtkInfoBar" id="infobar">
            <property name="visible">0</property>
            <property name="hexpand">1</property>
            <child>
              <object class="GtkLabel" id="message">
                <property name="hexpand">1</property>
              </object>
            </child>
            <child type="action">
              <object class="GtkButton">
                <property name="valign">center</property>
                <property name="label" translatable="yes">_OK</property>
                <property name="use-underline">1</property>
              </object>
            </child>
            <layout>
              <property name="column">0</property>
              <property name="row">1</property>
            </layout>
          </object>
        </child>
        <child>
          <object class="GtkScrolledWindow">
            <property name="has-frame">1</property>
            <child>
              <object class="GtkTextView">
                <property name="hexpand">1</property>
                <property name="vexpand">1</property>
                <property name="buffer">buffer</property>
              </object>
            </child>
            <layout>
              <property name="column">0</property>
              <property name="row">2</property>
            </layout>
          </object>
        </child>
        <child>
          <object class="GtkStatusbar" id="status">
            <property name="hexpand">1</property>
            <layout>
              <property name="column">0</property>
              <property name="row">3</property>
            </layout>
          </object>
        </child>
      </object>
    </child>
  </object>
  <menu id="toolmenu">
    <item>
      <attribute name="label">File1</attribute>
      <attribute name="action">win.file1</attribute>
    </item>
  </menu>
  <object class="GtkTextBuffer" id="buffer">
  </object>
</interface>
EOT
  return s
end

def get_menu() : String

s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <menu id="menubar">
    <submenu>
      <attribute name="label" translatable="yes">_Application</attribute>
      <section>
        <item>
          <attribute name="label" translatable="yes">_New</attribute>
          <attribute name="action">app.new</attribute>
          <attribute name="accel">&lt;Control&gt;n</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_Open</attribute>
          <attribute name="action">app.open</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_Save</attribute>
          <attribute name="action">app.save</attribute>
          <attribute name="accel">&lt;Control&gt;s</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">Save _As...</attribute>
          <attribute name="action">app.saveas</attribute>
          <attribute name="accel">&lt;Control&gt;&lt;Shift&gt;s</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label" translatable="yes">_Quit</attribute>
          <attribute name="action">app.quit</attribute>
          <attribute name="accel">&lt;Control&gt;q</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label" translatable="yes">_File</attribute>
      <section>
        <item>
          <attribute name="label" translatable="yes">_Prefer Dark Theme</attribute>
          <attribute name="action">app.dark</attribute>
        </item>
        <submenu>
          <attribute name="label" translatable="yes">_Color</attribute>
          <section>
            <item>
              <attribute name="label" translatable="yes">_Red</attribute>
              <attribute name="action">app.color</attribute>
              <attribute name="target">red</attribute>
              <attribute name="accel">&lt;Control&gt;r</attribute>
            </item>
            <item>
              <attribute name="label" translatable="yes">_Green</attribute>
              <attribute name="action">app.color</attribute>
              <attribute name="target">green</attribute>
              <attribute name="accel">&lt;Control&gt;g</attribute>
            </item>
            <item>
              <attribute name="label" translatable="yes">_Blue</attribute>
              <attribute name="action">app.color</attribute>
              <attribute name="target">blue</attribute>
              <attribute name="accel">&lt;Control&gt;b</attribute>
            </item>
          </section>
        </submenu>
        <submenu>
          <attribute name="label" translatable="yes">_Shape</attribute>
          <section>
            <item>
              <attribute name="label" translatable="yes">_Square</attribute>
              <attribute name="action">app.shape</attribute>
              <attribute name="target">square</attribute>
              <attribute name="accel">&lt;Control&gt;s</attribute>
            </item>
            <item>
              <attribute name="label" translatable="yes">_Rectangle</attribute>
              <attribute name="action">app.shape</attribute>
              <attribute name="target">rectangle</attribute>
              <attribute name="accel">&lt;Control&gt;r</attribute>
            </item>
            <item>
              <attribute name="label" translatable="yes">_Oval</attribute>
              <attribute name="action">app.shape</attribute>
              <attribute name="target">oval</attribute>
              <attribute name="accel">&lt;Control&gt;o</attribute>
            </item>
          </section>
        </submenu>
        <item>
          <attribute name="label" translatable="yes">_Bold</attribute>
          <attribute name="action">app.bold</attribute>
          <attribute name="accel">&lt;Control&gt;&lt;Shift&gt;b</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label" translatable="yes">_Help</attribute>
      <item>
        <attribute name="label" translatable="yes">_About</attribute>
        <attribute name="action">app.about</attribute>
        <attribute name="accel">&lt;Control&gt;a</attribute>
      </item>
    </submenu>
  </menu>
</interface>
EOT
  return s
end

def get_message_dialog(text : String) : String

s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <requires lib="gtk+" version="4.0"/>
  <object class="GtkDialog" id="alert_dialog">
    <property name="title" translatable="yes">Message</property>
    <property name="resizable">False</property>
    <property name="decorated">True</property>
    <property name="modal">True</property>
    <child>
      <object class="GtkBox" id="contentArea">
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkLabel">
            <property name="wrap">True</property>
            <property name="selectable">True</property>
            <property name="xalign">0</property>
            <property name="margin-start">10</property>
            <property name="margin-end">10</property>
            <property name="margin-top">10</property>
            <property name="margin-bottom">10</property>
            <property name="label" translatable="yes">#{text}</property>
          </object>
        </child>
        <child>
          <object class="GtkBox" id="buttonBox">
            <property name="halign">center</property>
            <child>
              <object class="GtkButton" id="button_close">
                <property name="label" translatable="yes">Close</property>
                <property name="can-focus">True</property>
                <property name="receives-default">True</property>
              </object>
            </child>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
EOT
  return s
end
