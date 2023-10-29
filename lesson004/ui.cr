def get_ui() : String
  s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkListStore" id="liststore1">
    <columns>
      <column type="gchararray"/>
      <column type="gchararray"/>
      <column type="gint"/>
      <column type="gchararray"/>
    </columns>
    <data>
      <row>
        <col id="0" translatable="yes">John</col>
        <col id="1" translatable="yes">Doe</col>
        <col id="2">25</col>
        <col id="3" translatable="yes">This is the John Doe row</col>
      </row>
      <row>
        <col id="0" translatable="yes">Mary</col>
        <col id="1" translatable="yes">Unknown</col>
        <col id="2">50</col>
        <col id="3" translatable="yes">This is the Mary Unknown row</col>
      </row>
    </data>
  </object>
  <menu id="menubar">
    <submenu>
      <attribute name="label" translatable="yes">_File</attribute>
      <section>
        <item>
          <attribute name="label" translatable="yes">_New</attribute>
          <attribute name="action">app.new</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_Open</attribute>
          <attribute name="action">app.open</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_Save</attribute>
          <attribute name="action">app.save</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">Save _As</attribute>
          <attribute name="action">app.saveas</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label" translatable="yes">_Quit</attribute>
          <attribute name="action">app.quit</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label" translatable="yes">_Edit</attribute>
      <section>
        <item>
          <attribute name="label" translatable="yes">_Copy</attribute>
          <attribute name="action">app.copy</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_Cut</attribute>
          <attribute name="action">app.cut</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_Paste</attribute>
          <attribute name="action">app.paste</attribute>
        </item>
      </section>
    </submenu>
    <submenu>
      <attribute name="label" translatable="yes">_Help</attribute>
      <section>
        <item>
          <attribute name="label" translatable="yes">_Help</attribute>
          <attribute name="action">app.help</attribute>
        </item>
        <item>
          <attribute name="label" translatable="yes">_About</attribute>
          <attribute name="action">app.about</attribute>
        </item>
      </section>
    </submenu>
  </menu>
  <object class="GtkAboutDialog" id="aboutdialog1">
    <property name="program-name" translatable="yes">Builder demo</property>
    <property name="logo-icon-name" translatable="yes">org.gtk.Demo4</property>
    <property name="modal">True</property>
  </object>
  <object class="GtkWindow" id="window">
    <property name="default-height">250</property>
    <property name="default-width">440</property>
    <property name="title" translatable="yes">Builder</property>
    <child>
      <object class="GtkBox" id="vbox1">
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkPopoverMenuBar" id="menubar1">
            <property name="menu-model">menubar</property>
            <accessibility>
              <property name="label">Main Menu</property>
            </accessibility>
          </object>
        </child>
        <child>
          <object class="GtkBox" id="toolbar1">
            <property name="accessible-role">toolbar</property>
            <property name="css-classes">toolbar</property>
            <accessibility>
              <property name="label">Toolbar</property>
            </accessibility>
            <child>
              <object class="GtkButton">
                <property name="label" translatable="yes">New</property>
                <property name="tooltip-text" translatable="yes">Create a new file</property>
                <property name="icon-name">document-new</property>
                <property name="action-name">app.new</property>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label" translatable="yes">Open</property>
                <property name="tooltip-text" translatable="yes">Open a file</property>
                <property name="icon-name">document-open</property>
                <property name="action-name">app.open</property>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label" translatable="yes">Save</property>
                <property name="tooltip-text" translatable="yes">Save a file</property>
                <property name="icon-name">document-save</property>
                <property name="action-name">app.save</property>
              </object>
            </child>
            <child>
              <object class="GtkSeparator"/>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label" translatable="yes">Copy</property>
                <property name="tooltip-text" translatable="yes">Copy selected object into the clipboard</property>
                <property name="icon-name">edit-copy</property>
                <property name="action-name">app.copy</property>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label" translatable="yes">Cut</property>
                <property name="tooltip-text" translatable="yes">Cut selected object into the clipboard</property>
                <property name="icon-name">edit-cut</property>
                <property name="action-name">app.cut</property>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label" translatable="yes">Paste</property>
                <property name="tooltip-text" translatable="yes">Paste object from the clipboard</property>
                <property name="icon-name">edit-paste</property>
                <property name="action-name">app.paste</property>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkScrolledWindow" id="scrolledwindow1">
            <property name="has-frame">1</property>
            <property name="hexpand">1</property>
            <property name="vexpand">1</property>
            <child>
              <object class="GtkTreeView" id="treeview1">
                <property name="model">liststore1</property>
                <property name="tooltip-column">3</property>
                <child>
                  <object class="GtkTreeViewColumn" id="column1">
                    <property name="title">Name</property>
                    <child>
                      <object class="GtkCellRendererText" id="renderer1"/>
                      <attributes>
                        <attribute name="text">0</attribute>
                      </attributes>
                    </child>
                  </object>
                </child>
                <child>
                  <object class="GtkTreeViewColumn" id="column2">
                    <property name="title">Surname</property>
                    <child>
                      <object class="GtkCellRendererText" id="renderer2"/>
                      <attributes>
                        <attribute name="text">1</attribute>
                      </attributes>
                    </child>
                  </object>
                </child>
                <child>
                  <object class="GtkTreeViewColumn" id="column3">
                    <property name="title">Age</property>
                    <child>
                      <object class="GtkCellRendererText" id="renderer3"/>
                      <attributes>
                        <attribute name="text">2</attribute>
                      </attributes>
                    </child>
                  </object>
                </child>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkStatusbar" id="statusbar"/>
        </child>
      </object>
    </child>
  </object>
</interface>
EOT
  return s
end
