def get_ui() : String
  s = <<-EOT
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GdkCursor" id="default_cursor">
    <property name="name">default</property>
  </object>
  <object class="GdkCursor" id="default_cursor_image">
    <property name="texture">images/default_cursor.png</property>
    <property name="hotspot-x">5</property>
    <property name="hotspot-y">5</property>
  </object>
  <object class="GdkCursor" id="default_cursor_fallback">
    <property name="name">default</property>
    <property name="fallback">default_cursor_image</property>
  </object>
  <object class="GdkCursor" id="default_cursor_image_fallback">
    <property name="texture">images/default_cursor.png</property>
    <property name="hotspot-x">5</property>
    <property name="hotspot-y">5</property>
    <property name="fallback">default_cursor</property>
  </object>
  <object class="GdkCursor" id="none_cursor">
    <property name="name">none</property>
  </object>
  <object class="GdkCursor" id="none_cursor_image">
    <property name="texture">images/none_cursor.png</property>
  </object>
  <object class="GdkCursor" id="none_cursor_fallback">
    <property name="name">none</property>
    <property name="fallback">none_cursor_image</property>
  </object>
  <object class="GdkCursor" id="none_cursor_image_fallback">
    <property name="texture">images/none_cursor.png</property>
    <property name="fallback">none_cursor</property>
  </object>
  <object class="GdkCursor" id="gtk-logo_cursor">
    <property name="name">gtk-logo</property>
  </object>
  <object class="GdkCursor" id="gtk-logo_cursor_image">
    <property name="texture">images/gtk_logo_cursor.png</property>
    <property name="hotspot-x">18</property>
    <property name="hotspot-y">2</property>
  </object>
  <object class="GdkCursor" id="gtk-logo_cursor_fallback">
    <property name="name">gtk-logo</property>
    <property name="fallback">gtk-logo_cursor_image</property>
  </object>
  <object class="GdkCursor" id="gtk-logo_cursor_image_fallback">
    <property name="texture">images/gtk_logo_cursor.png</property>
    <property name="hotspot-x">18</property>
    <property name="hotspot-y">2</property>
    <property name="fallback">gtk-logo_cursor</property>
  </object>
  <object class="GdkCursor" id="context-menu_cursor">
    <property name="name">context-menu</property>
  </object>
  <object class="GdkCursor" id="context-menu_cursor_image">
    <property name="texture">images/context_menu_cursor.png</property>
    <property name="hotspot-x">5</property>
    <property name="hotspot-y">5</property>
  </object>
  <object class="GdkCursor" id="context-menu_cursor_fallback">
    <property name="name">context-menu</property>
    <property name="fallback">context-menu_cursor_image</property>
  </object>
  <object class="GdkCursor" id="context-menu_cursor_image_fallback">
    <property name="texture">images/context_menu_cursor.png</property>
    <property name="hotspot-x">5</property>
    <property name="hotspot-y">5</property>
    <property name="fallback">context-menu_cursor</property>
  </object>
  <object class="GdkCursor" id="help_cursor">
    <property name="name">help</property>
  </object>
  <object class="GdkCursor" id="help_cursor_image">
    <property name="texture">images/help_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">27</property>
  </object>
  <object class="GdkCursor" id="help_cursor_fallback">
    <property name="name">help</property>
    <property name="fallback">help_cursor_image</property>
  </object>
  <object class="GdkCursor" id="help_cursor_image_fallback">
    <property name="texture">images/help_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">27</property>
    <property name="fallback">help_cursor</property>
  </object>
  <object class="GdkCursor" id="pointer_cursor">
    <property name="name">pointer</property>
  </object>
  <object class="GdkCursor" id="pointer_cursor_image">
    <property name="texture">images/pointer_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">9</property>
  </object>
  <object class="GdkCursor" id="pointer_cursor_fallback">
    <property name="name">pointer</property>
    <property name="fallback">pointer_cursor_image</property>
  </object>
  <object class="GdkCursor" id="pointer_cursor_image_fallback">
    <property name="texture">images/pointer_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">9</property>
    <property name="fallback">pointer_cursor</property>
  </object>
  <object class="GdkCursor" id="progress_cursor">
    <property name="name">progress</property>
  </object>
  <object class="GdkCursor" id="progress_cursor_image">
    <property name="texture">images/progress_cursor.png</property>
    <property name="hotspot-x">5</property>
    <property name="hotspot-y">4</property>
  </object>
  <object class="GdkCursor" id="progress_cursor_fallback">
    <property name="name">progress</property>
    <property name="fallback">progress_cursor_image</property>
  </object>
  <object class="GdkCursor" id="progress_cursor_image_fallback">
    <property name="texture">images/progress_cursor.png</property>
    <property name="hotspot-x">5</property>
    <property name="hotspot-y">4</property>
    <property name="fallback">progress_cursor</property>
  </object>
  <object class="GdkCursor" id="wait_cursor">
    <property name="name">wait</property>
  </object>
  <object class="GdkCursor" id="wait_cursor_image">
    <property name="texture">images/wait_cursor.png</property>
    <property name="hotspot-x">11</property>
    <property name="hotspot-y">11</property>
  </object>
  <object class="GdkCursor" id="wait_cursor_fallback">
    <property name="name">wait</property>
    <property name="fallback">wait_cursor_image</property>
  </object>
  <object class="GdkCursor" id="wait_cursor_image_fallback">
    <property name="texture">images/wait_cursor.png</property>
    <property name="hotspot-x">11</property>
    <property name="hotspot-y">11</property>
    <property name="fallback">wait_cursor</property>
  </object>
  <object class="GdkCursor" id="cell_cursor">
    <property name="name">cell</property>
  </object>
  <object class="GdkCursor" id="cell_cursor_image">
    <property name="texture">images/cell_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="cell_cursor_fallback">
    <property name="name">cell</property>
    <property name="fallback">cell_cursor_image</property>
  </object>
  <object class="GdkCursor" id="cell_cursor_image_fallback">
    <property name="texture">images/cell_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">cell_cursor</property>
  </object>
  <object class="GdkCursor" id="crosshair_cursor">
    <property name="name">crosshair</property>
  </object>
  <object class="GdkCursor" id="crosshair_cursor_image">
    <property name="texture">images/crosshair_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="crosshair_cursor_fallback">
    <property name="name">crosshair</property>
    <property name="fallback">crosshair_cursor_image</property>
  </object>
  <object class="GdkCursor" id="crosshair_cursor_image_fallback">
    <property name="texture">images/crosshair_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">crosshair_cursor</property>
  </object>
  <object class="GdkCursor" id="text_cursor">
    <property name="name">text</property>
  </object>
  <object class="GdkCursor" id="text_cursor_image">
    <property name="texture">images/text_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="text_cursor_fallback">
    <property name="name">text</property>
    <property name="fallback">text_cursor_image</property>
  </object>
  <object class="GdkCursor" id="text_cursor_image_fallback">
    <property name="texture">images/text_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">text_cursor</property>
  </object>
  <object class="GdkCursor" id="vertical-text_cursor">
    <property name="name">vertical-text</property>
  </object>
  <object class="GdkCursor" id="vertical-text_cursor_image">
    <property name="texture">images/vertical_text_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="vertical-text_cursor_fallback">
    <property name="name">vertical-text</property>
    <property name="fallback">vertical-text_cursor_image</property>
  </object>
  <object class="GdkCursor" id="vertical-text_cursor_image_fallback">
    <property name="texture">images/vertical_text_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">vertical-text_cursor</property>
  </object>
  <object class="GdkCursor" id="alias_cursor">
    <property name="name">alias</property>
  </object>
  <object class="GdkCursor" id="alias_cursor_image">
    <property name="texture">images/alias_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
  </object>
  <object class="GdkCursor" id="alias_cursor_fallback">
    <property name="name">alias</property>
    <property name="fallback">alias_cursor_image</property>
  </object>
  <object class="GdkCursor" id="alias_cursor_image_fallback">
    <property name="texture">images/alias_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
    <property name="fallback">alias_cursor</property>
  </object>
  <object class="GdkCursor" id="copy_cursor">
    <property name="name">copy</property>
  </object>
  <object class="GdkCursor" id="copy_cursor_image">
    <property name="texture">images/copy_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
  </object>
  <object class="GdkCursor" id="copy_cursor_fallback">
    <property name="name">copy</property>
    <property name="fallback">copy_cursor_image</property>
  </object>
  <object class="GdkCursor" id="copy_cursor_image_fallback">
    <property name="texture">images/copy_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
    <property name="fallback">copy_cursor</property>
  </object>
  <object class="GdkCursor" id="move_cursor">
    <property name="name">move</property>
  </object>
  <object class="GdkCursor" id="move_cursor_image">
    <property name="texture">images/move_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
  </object>
  <object class="GdkCursor" id="move_cursor_fallback">
    <property name="name">move</property>
    <property name="fallback">move_cursor_image</property>
  </object>
  <object class="GdkCursor" id="move_cursor_image_fallback">
    <property name="texture">images/move_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
    <property name="fallback">move_cursor</property>
  </object>
  <object class="GdkCursor" id="no-drop_cursor">
    <property name="name">no-drop</property>
  </object>
  <object class="GdkCursor" id="no-drop_cursor_image">
    <property name="texture">images/no_drop_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
  </object>
  <object class="GdkCursor" id="no-drop_cursor_fallback">
    <property name="name">no-drop</property>
    <property name="fallback">no-drop_cursor_image</property>
  </object>
  <object class="GdkCursor" id="no-drop_cursor_image_fallback">
    <property name="texture">images/no_drop_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
    <property name="fallback">no-drop_cursor</property>
  </object>
  <object class="GdkCursor" id="not-allowed_cursor">
    <property name="name">not-allowed</property>
  </object>
  <object class="GdkCursor" id="not-allowed_cursor_image">
    <property name="texture">images/not_allowed_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
  </object>
  <object class="GdkCursor" id="not-allowed_cursor_fallback">
    <property name="name">not-allowed</property>
    <property name="fallback">not-allowed_cursor_image</property>
  </object>
  <object class="GdkCursor" id="not-allowed_cursor_image_fallback">
    <property name="texture">images/not_allowed_cursor.png</property>
    <property name="hotspot-x">12</property>
    <property name="hotspot-y">11</property>
    <property name="fallback">not-allowed_cursor</property>
  </object>
  <object class="GdkCursor" id="grab_cursor">
    <property name="name">grab</property>
  </object>
  <object class="GdkCursor" id="grab_cursor_image">
    <property name="texture">images/grab_cursor.png</property>
    <property name="hotspot-x">10</property>
    <property name="hotspot-y">6</property>
  </object>
  <object class="GdkCursor" id="grab_cursor_fallback">
    <property name="name">grab</property>
    <property name="fallback">grab_cursor_image</property>
  </object>
  <object class="GdkCursor" id="grab_cursor_image_fallback">
    <property name="texture">images/grab_cursor.png</property>
    <property name="hotspot-x">10</property>
    <property name="hotspot-y">6</property>
    <property name="fallback">grab_cursor</property>
  </object>
  <object class="GdkCursor" id="grabbing_cursor">
    <property name="name">grabbing</property>
  </object>
  <object class="GdkCursor" id="grabbing_cursor_image">
    <property name="texture">images/grabbing_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">14</property>
  </object>
  <object class="GdkCursor" id="grabbing_cursor_fallback">
    <property name="name">grabbing</property>
    <property name="fallback">grabbing_cursor_image</property>
  </object>
  <object class="GdkCursor" id="grabbing_cursor_image_fallback">
    <property name="texture">images/grabbing_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">14</property>
    <property name="fallback">grabbing_cursor</property>
  </object>
  <object class="GdkCursor" id="all-scroll_cursor">
    <property name="name">all-scroll</property>
  </object>
  <object class="GdkCursor" id="all-scroll_cursor_image">
    <property name="texture">images/all_scroll_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="all-scroll_cursor_fallback">
    <property name="name">all-scroll</property>
    <property name="fallback">all-scroll_cursor_image</property>
  </object>
  <object class="GdkCursor" id="all-scroll_cursor_image_fallback">
    <property name="texture">images/all_scroll_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">all-scroll_cursor</property>
  </object>
  <object class="GdkCursor" id="col-resize_cursor">
    <property name="name">col-resize</property>
  </object>
  <object class="GdkCursor" id="col-resize_cursor_image">
    <property name="texture">images/col_resize_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="col-resize_cursor_fallback">
    <property name="name">col-resize</property>
    <property name="fallback">col-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="col-resize_cursor_image_fallback">
    <property name="texture">images/col_resize_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">col-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="row-resize_cursor">
    <property name="name">row-resize</property>
  </object>
  <object class="GdkCursor" id="row-resize_cursor_image">
    <property name="texture">images/row_resize_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">17</property>
  </object>
  <object class="GdkCursor" id="row-resize_cursor_fallback">
    <property name="name">row-resize</property>
    <property name="fallback">row-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="row-resize_cursor_image_fallback">
    <property name="texture">images/row_resize_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">17</property>
    <property name="fallback">row-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="n-resize_cursor">
    <property name="name">n-resize</property>
  </object>
  <object class="GdkCursor" id="n-resize_cursor_image">
    <property name="texture">images/n_resize_cursor.png</property>
    <property name="hotspot-x">17</property>
    <property name="hotspot-y">7</property>
  </object>
  <object class="GdkCursor" id="n-resize_cursor_fallback">
    <property name="name">n-resize</property>
    <property name="fallback">n-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="n-resize_cursor_image_fallback">
    <property name="texture">images/n_resize_cursor.png</property>
    <property name="hotspot-x">17</property>
    <property name="hotspot-y">7</property>
    <property name="fallback">n-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="e-resize_cursor">
    <property name="name">e-resize</property>
  </object>
  <object class="GdkCursor" id="e-resize_cursor_image">
    <property name="texture">images/e_resize_cursor.png</property>
    <property name="hotspot-x">25</property>
    <property name="hotspot-y">17</property>
  </object>
  <object class="GdkCursor" id="e-resize_cursor_fallback">
    <property name="name">e-resize</property>
    <property name="fallback">e-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="e-resize_cursor_image_fallback">
    <property name="texture">images/e_resize_cursor.png</property>
    <property name="hotspot-x">25</property>
    <property name="hotspot-y">17</property>
    <property name="fallback">e-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="s-resize_cursor">
    <property name="name">s-resize</property>
  </object>
  <object class="GdkCursor" id="s-resize_cursor_image">
    <property name="texture">images/s_resize_cursor.png</property>
    <property name="hotspot-x">17</property>
    <property name="hotspot-y">23</property>
  </object>
  <object class="GdkCursor" id="s-resize_cursor_fallback">
    <property name="name">s-resize</property>
    <property name="fallback">s-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="s-resize_cursor_image_fallback">
    <property name="texture">images/s_resize_cursor.png</property>
    <property name="hotspot-x">17</property>
    <property name="hotspot-y">23</property>
    <property name="fallback">s-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="w-resize_cursor">
    <property name="name">w-resize</property>
  </object>
  <object class="GdkCursor" id="w-resize_cursor_image">
    <property name="texture">images/w_resize_cursor.png</property>
    <property name="hotspot-x">8</property>
    <property name="hotspot-y">17</property>
  </object>
  <object class="GdkCursor" id="w-resize_cursor_fallback">
    <property name="name">w-resize</property>
    <property name="fallback">w-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="w-resize_cursor_image_fallback">
    <property name="texture">images/w_resize_cursor.png</property>
    <property name="hotspot-x">8</property>
    <property name="hotspot-y">17</property>
    <property name="fallback">w-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="ne-resize_cursor">
    <property name="name">ne-resize</property>
  </object>
  <object class="GdkCursor" id="ne-resize_cursor_image">
    <property name="texture">images/ne_resize_cursor.png</property>
    <property name="hotspot-x">20</property>
    <property name="hotspot-y">13</property>
  </object>
  <object class="GdkCursor" id="ne-resize_cursor_fallback">
    <property name="name">ne-resize</property>
    <property name="fallback">ne-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="ne-resize_cursor_image_fallback">
    <property name="texture">images/ne_resize_cursor.png</property>
    <property name="hotspot-x">20</property>
    <property name="hotspot-y">13</property>
    <property name="fallback">ne-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="nw-resize_cursor">
    <property name="name">nw-resize</property>
  </object>
  <object class="GdkCursor" id="nw-resize_cursor_image">
    <property name="texture">images/nw_resize_cursor.png</property>
    <property name="hotspot-x">13</property>
    <property name="hotspot-y">13</property>
  </object>
  <object class="GdkCursor" id="nw-resize_cursor_fallback">
    <property name="name">nw-resize</property>
    <property name="fallback">nw-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="nw-resize_cursor_image_fallback">
    <property name="texture">images/nw_resize_cursor.png</property>
    <property name="hotspot-x">13</property>
    <property name="hotspot-y">13</property>
    <property name="fallback">nw-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="se-resize_cursor">
    <property name="name">se-resize</property>
  </object>
  <object class="GdkCursor" id="se-resize_cursor_image">
    <property name="texture">images/se_resize_cursor.png</property>
    <property name="hotspot-x">19</property>
    <property name="hotspot-y">19</property>
  </object>
  <object class="GdkCursor" id="se-resize_cursor_fallback">
    <property name="name">se-resize</property>
    <property name="fallback">se-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="se-resize_cursor_image_fallback">
    <property name="texture">images/se_resize_cursor.png</property>
    <property name="hotspot-x">19</property>
    <property name="hotspot-y">19</property>
    <property name="fallback">se-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="sw-resize_cursor">
    <property name="name">sw-resize</property>
  </object>
  <object class="GdkCursor" id="sw-resize_cursor_image">
    <property name="texture">images/sw_resize_cursor.png</property>
    <property name="hotspot-x">13</property>
    <property name="hotspot-y">19</property>
  </object>
  <object class="GdkCursor" id="sw-resize_cursor_fallback">
    <property name="name">sw-resize</property>
    <property name="fallback">sw-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="sw-resize_cursor_image_fallback">
    <property name="texture">images/sw_resize_cursor.png</property>
    <property name="hotspot-x">13</property>
    <property name="hotspot-y">19</property>
    <property name="fallback">sw-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="ew-resize_cursor">
    <property name="name">ew-resize</property>
  </object>
  <object class="GdkCursor" id="ew-resize_cursor_image">
    <property name="texture">images/ew_resize_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">15</property>
  </object>
  <object class="GdkCursor" id="ew-resize_cursor_fallback">
    <property name="name">ew-resize</property>
    <property name="fallback">ew-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="ew-resize_cursor_image_fallback">
    <property name="texture">images/ew_resize_cursor.png</property>
    <property name="hotspot-x">16</property>
    <property name="hotspot-y">15</property>
    <property name="fallback">ew-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="ns-resize_cursor">
    <property name="name">ns-resize</property>
  </object>
  <object class="GdkCursor" id="ns-resize_cursor_image">
    <property name="texture">images/ns_resize_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">17</property>
  </object>
  <object class="GdkCursor" id="ns-resize_cursor_fallback">
    <property name="name">ns-resize</property>
    <property name="fallback">ns-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="ns-resize_cursor_image_fallback">
    <property name="texture">images/ns_resize_cursor.png</property>
    <property name="hotspot-x">15</property>
    <property name="hotspot-y">17</property>
    <property name="fallback">ns-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="nesw-resize_cursor">
    <property name="name">nesw-resize</property>
  </object>
  <object class="GdkCursor" id="nesw-resize_cursor_image">
    <property name="texture">images/nesw_resize_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">14</property>
  </object>
  <object class="GdkCursor" id="nesw-resize_cursor_fallback">
    <property name="name">nesw-resize</property>
    <property name="fallback">nesw-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="nesw-resize_cursor_image_fallback">
    <property name="texture">images/nesw_resize_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">14</property>
    <property name="fallback">nesw-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="nwse-resize_cursor">
    <property name="name">nwse-resize</property>
  </object>
  <object class="GdkCursor" id="nwse-resize_cursor_image">
    <property name="texture">images/nwse_resize_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">14</property>
  </object>
  <object class="GdkCursor" id="nwse-resize_cursor_fallback">
    <property name="name">nwse-resize</property>
    <property name="fallback">nwse-resize_cursor_image</property>
  </object>
  <object class="GdkCursor" id="nwse-resize_cursor_image_fallback">
    <property name="texture">images/nwse_resize_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">14</property>
    <property name="fallback">nwse-resize_cursor</property>
  </object>
  <object class="GdkCursor" id="zoom-in_cursor">
    <property name="name">zoom-in</property>
  </object>
  <object class="GdkCursor" id="zoom-in_cursor_image">
    <property name="texture">images/zoom_in_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">13</property>
  </object>
  <object class="GdkCursor" id="zoom-in_cursor_fallback">
    <property name="name">zoom-in</property>
    <property name="fallback">zoom-in_cursor_image</property>
  </object>
  <object class="GdkCursor" id="zoom-in_cursor_image_fallback">
    <property name="texture">images/zoom_in_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">13</property>
    <property name="fallback">zoom-in_cursor</property>
  </object>
  <object class="GdkCursor" id="zoom-out_cursor">
    <property name="name">zoom-out</property>
  </object>
  <object class="GdkCursor" id="zoom-out_cursor_image">
    <property name="texture">images/zoom_out_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">13</property>
  </object>
  <object class="GdkCursor" id="zoom-out_cursor_fallback">
    <property name="name">zoom-out</property>
    <property name="fallback">zoom-out_cursor_image</property>
  </object>
  <object class="GdkCursor" id="zoom-out_cursor_image_fallback">
    <property name="texture">images/zoom_out_cursor.png</property>
    <property name="hotspot-x">14</property>
    <property name="hotspot-y">13</property>
    <property name="fallback">zoom-out_cursor</property>
  </object>
  <object class="GtkWindow" id="window">
    <property name="default-width">300</property>
    <property name="default-height">300</property>
    <property name="title">Cursors</property>
    <child>
      <object class="GtkScrolledWindow">
        <property name="hscrollbar-policy">never</property>
        <property name="propagate-natural-height">1</property>
        <property name="hexpand">1</property>
        <child>
          <object class="GtkBox">
            <property name="orientation">vertical</property>
            <property name="margin-start">60</property>
            <property name="margin-end">60</property>
            <property name="margin-top">60</property>
            <property name="margin-bottom">60</property>
            <property name="spacing">10</property>
            <property name="halign">center</property>
            <child>
              <object class="GtkFrame">
                <child>
                  <object class="GtkListBox">
                    <property name="selection-mode">none</property>
                    <style>
                      <class name="view"/>
                    </style>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/default_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">default</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">default_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;default&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">default_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">default_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;default&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">default_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;default&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/none_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">none</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">none_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;none&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">none_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">none_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;none&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">none_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;none&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/gtk_logo_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">gtk-logo</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">gtk-logo_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;gtk-logo&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">gtk-logo_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">gtk-logo_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;gtk-logo&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">gtk-logo_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;gtk-logo&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkFrame">
                <property name="hexpand">1</property>
                <child>
                  <object class="GtkListBox">
                    <property name="selection-mode">none</property>
                    <style>
                      <class name="view"/>
                    </style>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/context_menu_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">context-menu</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">context-menu_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;context-menu&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">context-menu_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">context-menu_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;context-menu&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">context-menu_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;context-menu&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/help_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">help</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">help_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;help&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">help_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">help_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;help&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">help_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;help&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/pointer_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">pointer</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">pointer_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;pointer&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">pointer_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">pointer_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;pointer&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">pointer_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;pointer&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/progress_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">progress</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">progress_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;progress&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">progress_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">progress_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;progress&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">progress_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;progress&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/wait_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">wait</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">wait_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;wait&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">wait_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">wait_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;wait&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">wait_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;wait&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkFrame">
                <property name="hexpand">1</property>
                <child>
                  <object class="GtkListBox">
                    <property name="selection-mode">none</property>
                    <style>
                      <class name="view"/>
                    </style>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/cell_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">cell</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">cell_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;cell&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">cell_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">cell_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;cell&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">cell_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;cell&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/crosshair_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">crosshair</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">crosshair_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;crosshair&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">crosshair_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">crosshair_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;crosshair&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">crosshair_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;crosshair&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/text_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">text</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">text_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;text&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">text_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">text_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;text&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">text_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;text&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/vertical_text_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">vertical-text</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">vertical-text_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;vertical-text&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">vertical-text_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">vertical-text_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;vertical-text&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">vertical-text_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;vertical-text&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkFrame">
                <property name="hexpand">1</property>
                <child>
                  <object class="GtkListBox">
                    <property name="selection-mode">none</property>
                    <style>
                      <class name="view"/>
                    </style>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/alias_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">alias</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">alias_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;alias&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">alias_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">alias_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;alias&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">alias_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;alias&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/copy_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">copy</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">copy_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;copy&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">copy_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">copy_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;copy&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">copy_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;copy&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/move_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">move</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">move_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;move&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">move_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">move_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;move&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">move_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;move&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/no_drop_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">no-drop</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">no-drop_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;no-drop&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">no-drop_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">no-drop_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;no-drop&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">no-drop_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;no-drop&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/not_allowed_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">not-allowed</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">not-allowed_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;not-allowed&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">not-allowed_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">not-allowed_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;not-allowed&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">not-allowed_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;not-allowed&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/grab_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">grab</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grab_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;grab&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grab_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grab_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;grab&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grab_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;grab&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/grabbing_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">grabbing</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grabbing_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;grabbing&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grabbing_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grabbing_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;grabbing&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">grabbing_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;grabbing&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkFrame">
                <property name="hexpand">1</property>
                <child>
                  <object class="GtkListBox">
                    <property name="selection-mode">none</property>
                    <style>
                      <class name="view"/>
                    </style>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/all_scroll_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">all-scroll</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">all-scroll_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;all-scroll&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">all-scroll_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">all-scroll_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;all-scroll&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">all-scroll_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;all-scroll&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/col_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">col-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">col-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;col-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">col-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">col-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;col-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">col-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;col-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/row_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">row-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">row-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;row-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">row-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">row-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;row-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">row-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;row-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/n_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">n-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">n-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;n-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">n-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">n-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;n-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">n-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;n-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/e_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">e-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">e-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;e-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">e-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">e-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;e-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">e-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;e-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/s_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">s-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">s-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;s-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">s-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">s-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;s-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">s-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;s-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/w_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">w-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">w-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;w-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">w-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">w-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;w-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">w-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;w-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/ne_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">ne-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ne-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;ne-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ne-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ne-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;ne-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ne-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;ne-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/nw_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">nw-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nw-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;nw-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nw-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nw-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;nw-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nw-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;nw-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/sw_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">sw-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">sw-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;sw-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">sw-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">sw-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;sw-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">sw-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;sw-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/se_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">se-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">se-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;se-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">se-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">se-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;se-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">se-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;se-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/ew_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">ew-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ew-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;ew-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ew-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ew-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;ew-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ew-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;ew-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/ns_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">ns-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ns-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;ns-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ns-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ns-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;ns-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">ns-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;ns-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/nesw_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">nesw-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nesw-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;nesw-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nesw-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nesw-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;nesw-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nesw-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;nesw-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/nwse_resize_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">nwse-resize</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nwse-resize_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;nwse-resize&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nwse-resize_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nwse-resize_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;nwse-resize&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">nwse-resize_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;nwse-resize&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkFrame">
                <property name="hexpand">1</property>
                <child>
                  <object class="GtkListBox">
                    <property name="selection-mode">none</property>
                    <style>
                      <class name="view"/>
                    </style>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/zoom_in_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">zoom-in</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-in_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;zoom-in&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-in_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-in_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;zoom-in&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-in_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;zoom-in&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                    <child>
                      <object class="GtkListBoxRow">
                        <property name="activatable">0</property>
                        <child>
                          <object class="GtkBox">
                            <property name="margin-start">10</property>
                            <property name="margin-end">10</property>
                            <property name="margin-top">10</property>
                            <property name="margin-bottom">10</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkImage">
                                <property name="paintable">images/zoom_out_cursor.png</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel">
                                <property name="label">zoom-out</property>
                                <property name="halign">start</property>
                                <property name="valign">baseline</property>
                                <property name="xalign">0.0</property>
                                <property name="hexpand">1</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-out_cursor</property>
                                <property name="tooltip-text" translatable="yes">The &quot;zoom-out&quot; named cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-out_cursor_image</property>
                                <property name="tooltip-text" translatable="yes">An image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-out_cursor_fallback</property>
                                <property name="tooltip-text" translatable="yes">The &quot;zoom-out&quot; named cursor falling back to an image cursor.</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkFrame">
                                <property name="width-request">32</property>
                                <property name="height-request">32</property>
                                <property name="cursor">zoom-out_cursor_image_fallback</property>
                                <property name="tooltip-text" translatable="yes">An image cursor falling back to the &quot;zoom-out&quot; cursor.</property>
                              </object>
                            </child>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
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
