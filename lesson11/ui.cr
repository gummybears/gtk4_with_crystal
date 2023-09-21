def get_ui() : String

s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkApplicationWindow" id="window">
    <property name="title">Lesson11: Text editor</property>
    <property name="default-width">600</property>
    <property name="default-height">400</property>
    <child>
      <object class="GtkBox">
        <child>
          <object class="GtkNotebook" id="notebook">
            <property name="hexpand">TRUE</property>
            <property name="vexpand">TRUE</property>
          </object>
        </child>
      </object>
    </child>
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
      <attribute name="label">File</attribute>
      <section>
        <item>
          <attribute name="label">New</attribute>
          <attribute name="action">app.new</attribute>
        </item>
        <item>
          <attribute name="label">Open</attribute>
          <attribute name="action">app.open</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label">Save</attribute>
          <attribute name="action">app.save</attribute>
        </item>
        <item>
          <attribute name="label">Save As…</attribute>
          <attribute name="action">app.saveas</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label">Close</attribute>
          <attribute name="action">app.close</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label">Quit</attribute>
          <attribute name="action">app.quit</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label">Edit</attribute>
      <section>
        <item>
          <attribute name="label">Cut</attribute>
          <attribute name="action">app.cut</attribute>
        </item>
        <item>
          <attribute name="label">Copy</attribute>
          <attribute name="action">app.copy</attribute>
        </item>
        <item>
          <attribute name="label">Paste</attribute>
          <attribute name="action">app.paste</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label">Select All</attribute>
          <attribute name="action">app.selectall</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label">View</attribute>
      <section>
        <item>
          <attribute name="label">Full Screen</attribute>
          <attribute name="action">win.fullscreen</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label">Help</attribute>
      <section>
        <item>
          <attribute name="label">About</attribute>
          <attribute name="action">app.about</attribute>
        </item>
        <item>
          <attribute name="label">Alert</attribute>
          <attribute name="action">app.alert</attribute>
        </item>
      </section>
    </submenu>

  </menu>
</interface>
EOT
  return s
end

def get_alert_dialog(filename : String) : String

s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <requires lib="gtk+" version="4.0"/>
  <object class="GtkDialog" id="alert_dialog">
    <property name="title" translatable="yes">Question</property>
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
            <property name="label" translatable="yes">The file '#{filename}' is not saved</property>
          </object>
        </child>
        <child>
          <object class="GtkLabel">
            <property name="wrap">True</property>
            <property name="selectable">True</property>
            <property name="xalign">0</property>
            <property name="margin-start">10</property>
            <property name="margin-end">10</property>
            <property name="margin-top">10</property>
            <property name="margin-bottom">10</property>
            <property name="label" translatable="yes">Do you want to save it before closing?</property>
          </object>
        </child>
        <child>
          <object class="GtkBox" id="buttonBox">
            <property name="orientation">horizontal</property>
            <child>
              <object class="GtkButton" id="button_cancel">
                <property name="label" translatable="yes">Cancel</property>
                <property name="can-focus">True</property>
                <property name="receives-default">True</property>
              </object>
            </child>
            <child>
              <object class="GtkButton" id="button_dont">
                <property name="label" translatable="yes">Don't Save</property>
                <property name="can-focus">True</property>
                <property name="receives-default">False</property>
              </object>
            </child>
            <child>
              <object class="GtkButton" id="button_save">
                <property name="label" translatable="yes">Save</property>
                <property name="can-focus">True</property>
                <property name="receives-default">False</property>
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

#
#<?xml version="1.0" encoding="UTF-8"?>
#<interface>
#  <object class="GtkWindow" id="alert_dialog">
#    <property name="title">Question</property>
#    <property name="modal">TRUE</property>
#  </object>
#  <child>
#    <object class="GtkBox">
#      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
#      <property name="spacing">12</property>
#      <property name="margin-top">12</property>
#      <property name="margin-bottom">12</property>
#      <property name="margin-start">12</property>
#      <property name="margin-end">12</property>
#      <child>
#        <object class="GtkImage">
#          <property name="icon-name">dialog-warning</property>
#          <property name="icon-size">GTK_ICON_SIZE_LARGE</property>
#        </object>
#      </child>
#      <child>
#        <object class="GtkLabel" id="lb_message">
#        </object>
#      </child>
#    </object>
#  </child>
#</interface>
#
#
#    <child>
#      <object class="GtkBox">
#        <child>
#          <object class="GtkLabel">
#          </object>
#        </child>
#
#        <object class="GtkBox">
#          <object class="GtkButton">
#            <property name"Cancel"></property>
#          </object>
#
#          <object class="GtkButton">
#            <property name"Don't save"></property>
#          </object>
#          <object class="GtkButton">
#            <property name"Save"></property>
#          </object>
#        </object>
#
#      </object>
#    </child>
#
