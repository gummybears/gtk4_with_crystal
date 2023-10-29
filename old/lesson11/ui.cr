def label(text : String)
s = <<-EOT
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
EOT
  return s
end

def button_with_icon_text(icon : String, text : String, id : String, default : String = "False")
s = <<-EOT
<child>
  <object class="GtkButton" id="#{id}">
    <property name="receives-default">#{default}</property>
    <child>
      <object class="GtkBox">
      <property name="spacing">8</property>
        <child>
          <object class="GtkImage">
            <property name="icon-name">#{icon}</property>
          </object>
        </child>
        <child>
          <object class="GtkButton">
            <property name="label">#{text}</property>
            <property name="has-frame">False</property>
          </object>
        </child>
      </object>
    </child>
  </object>
</child>
EOT
  return s
end

def get_alert_dialog(filename : String) : String
s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkDialog" id="alert_dialog">
    <property name="title" translatable="yes">Question</property>
    <property name="resizable">False</property>
    <property name="decorated">True</property>
    <property name="modal">True</property>
    <child>
      <object class="GtkBox" id="contentArea">
        <property name="orientation">vertical</property>
        <property name="spacing">12</property>
        #{label("The file '#{filename}' is not saved")}
        #{label("Do you want to save it before closing?")}
        <child>
          <object class="GtkBox" id="buttonBox">
            <property name="orientation">horizontal</property>
            <property name="spacing">12</property>
            #{button_with_icon_text("document-cancel","Cancel","button_cancel","True")}
            #{button_with_icon_text("document-new","Don't Save","button_dont")}
            #{button_with_icon_text("document-save","Save","button_save")}
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
EOT
  return s
end
