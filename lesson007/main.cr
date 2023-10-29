require "gtk4"

#
# Note: callbacks not implemented and masked entry not implemented
#
class Capital
  property group : String = ""
  property name  : String = ""

  def initialize(group,name)
    @group = group
    @name  = name
  end
end

class Capitals
  property data : Array(Capital)

  def initialize()
    @data = [] of Capital

    @data << Capital.new("A - B", "")
    @data << Capital.new("", "Albany" )
    @data << Capital.new("", "Annapolis" )
    @data << Capital.new("", "Atlanta" )
    @data << Capital.new("", "Augusta" )
    @data << Capital.new("", "Austin" )
    @data << Capital.new("", "Baton Rouge" )
    @data << Capital.new("", "Bismarck" )
    @data << Capital.new("", "Boise" )
    @data << Capital.new("", "Boston" )
    @data << Capital.new("C - D", "" )
    @data << Capital.new("", "Carson City" )
    @data << Capital.new("", "Charleston" )
    @data << Capital.new("", "Cheyenne" )
    @data << Capital.new("", "Columbia" )
    @data << Capital.new("", "Columbus" )
    @data << Capital.new("", "Concord" )
    @data << Capital.new("", "Denver" )
    @data << Capital.new("", "Des Moines" )
    @data << Capital.new("", "Dover" )
    @data << Capital.new("E - J", "" )
    @data << Capital.new("", "Frankfort" )
    @data << Capital.new("", "Harrisburg" )
    @data << Capital.new("", "Hartford" )
    @data << Capital.new("", "Helena" )
    @data << Capital.new("", "Honolulu" )
    @data << Capital.new("", "Indianapolis" )
    @data << Capital.new("", "Jackson" )
    @data << Capital.new("", "Jefferson City" )
    @data << Capital.new("", "Juneau" )
    @data << Capital.new("K - O", "" )
    @data << Capital.new("", "Lansing" )
    @data << Capital.new("", "Lincoln" )
    @data << Capital.new("", "Little Rock" )
    @data << Capital.new("", "Madison" )
    @data << Capital.new("", "Montgomery" )
    @data << Capital.new("", "Montpelier" )
    @data << Capital.new("", "Nashville" )
    @data << Capital.new("", "Oklahoma City" )
    @data << Capital.new("", "Olympia" )
    @data << Capital.new("P - S", "" )
    @data << Capital.new("", "Phoenix" )
    @data << Capital.new("", "Pierre" )
    @data << Capital.new("", "Providence" )
    @data << Capital.new("", "Raleigh" )
    @data << Capital.new("", "Richmond" )
    @data << Capital.new("", "Sacramento" )
    @data << Capital.new("", "Salem" )
    @data << Capital.new("", "Salt Lake City" )
    @data << Capital.new("", "Santa Fe" )
    @data << Capital.new("", "Springfield" )
    @data << Capital.new("", "St. Paul" )
    @data << Capital.new("T - Z", "" )
    @data << Capital.new("", "Tallahassee" )
    @data << Capital.new("", "Topeka" )
    @data << Capital.new("", "Trenton" )
    @data << Capital.new("", "")
  end

  def size
    @data.size
  end

  def get_capital(i : Int32) : Capital
    @data[i]
  end
end

class MaskEntry
  property entry : Gtk::Entry = Gtk::Entry.new
  property mask  : String = ""
end

class Lesson006 < Gtk::Application

  def initialize()
    super(application_id: "comboboxes.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate

    window = Gtk::Window.new
    window.set_default_size(400,400)
    window.title = "Comboboxes"

    vbox = Gtk::Box.new(orientation: :vertical, spacing: 12)
    vbox.margin_start  = 10
    vbox.margin_end    = 10
    vbox.margin_top    = 10
    vbox.margin_bottom = 10
    window.child       = vbox

    example1(vbox)
    example2(vbox)
    example3(vbox)
    example4(vbox)

    window.application = self
    window.present
  end

  def create_vbox(spacing : Int32, margin : Int32) : Gtk::Box
    box = Gtk::Box.new(orientation: :vertical, spacing: spacing)
    box.margin_start  = margin
    box.margin_end    = margin
    box.margin_top    = margin
    box.margin_bottom = margin
    box
  end

  #
  # A combobox demonstrating cell renderers, separators and
  # insensitive rows
  #
  def example1(vbox)
    frame = Gtk::Frame.new("Items with icons")
    vbox.append(frame)

    box = create_vbox(12,5)
    frame.child       = box

    model = create_icon_store()
    combo = Gtk::ComboBox.new_with_model(model)
    box.append(combo)

    # column 0, icon names
    renderer = Gtk::CellRendererPixbuf.new
    combo.as(Gtk::CellLayout).pack_start(renderer,false)
    combo.as(Gtk::CellLayout).add_attribute(renderer,"icon-name",0)
    # combo.as(Gtk::CellLayout).set_cell_data_func = ->set_sensitive(Gtk::CellLayout,Gtk::CellRenderer,Gtk::TreeModel,Gtk::TreeIter,Pointer(Void))

    # column 1, labels
    renderer = Gtk::CellRendererText.new
    combo.as(Gtk::CellLayout).pack_start(renderer,true)
    combo.as(Gtk::CellLayout).add_attribute(renderer,"text",1)
    # combo.as(Gtk::CellLayout).set_cell_data_func = ->set_sensitive(Gtk::CellLayout,Gtk::CellRenderer,Gtk::TreeModel,Gtk::TreeIter,Pointer(Void))

    combo.row_separator_func = row_separator
    # activate first row (zero based)
    combo.active = 0
  end

  #
  # A combobox demonstrating trees.
  #
  def example2(vbox)
    frame = Gtk::Frame.new("Where are we ?")
    vbox.append(frame)

    box = create_vbox(12,5)
    frame.child = box

    model = create_capital_store()
    combo = Gtk::ComboBox.new_with_model(model)
    box.append(combo)

    renderer = Gtk::CellRendererText.new
    combo.as(Gtk::CellLayout).pack_start(renderer,true)
    combo.as(Gtk::CellLayout).add_attribute(renderer,"text",0)

    # not working, crashes combo.as(Gtk::CellLayout).set_cell_data_func(renderer,->is_capital_sensitive(Gtk::CellLayout,Gtk::CellRenderer,Gtk::TreeModel,Gtk::TreeIter))
    # func = ->is_capital_sensitive(Gtk::CellLayout,Gtk::CellRenderer,Gtk::TreeModel,Gtk::TreeIter,Pointer(Void))
    # combo.as(Gtk::CellLayout).set_cell_data_func(renderer,func)

    #
    # following code when enabled
    # throws an Gtk error
    # (crystal-run-main.tmp:5496): Gtk-CRITICAL **: 17:59:27.196: gtk_tree_store_get_path: assertion 'iter->stamp == priv->stamp' failed
    #

    # path = Gtk::TreePath.new_from_indices([0, 8, -1])
    # iter = model.iter(path)
    # combo.active_iter = iter
  end

  #
  # A GtkComboBoxEntry with validation
  #
  def example3(vbox)

    frame = Gtk::Frame.new("Editable")
    vbox.append(frame)

    box = create_vbox(12,5)
    frame.child = box

    combo = fill_combo1()
    box.append(combo)

    #
    # Not implemented
    #

    # not sure how to define a new type for Gtk mask_entry      = MaskEntry.new
    # not sure how to define a new type for Gtk mask_entry.mask = "^([0-9]*|One|Two|2\302\275|Three)$";
    # not sure how to define a new type for Gtk entry           = GObject::Value.new(pointerof(mask_entry),GICrystal::Transfer::None)

    entry = Gtk::Entry.new
    combo.child = entry
  end

  #
  # A combobox with string IDs
  #
  def example4(vbox)
    frame = Gtk::Frame.new("String IDs")
    vbox.append(frame)

    box = create_vbox(12,5)
    frame.child = box

    combo = fill_combo2()
    box.append(combo)

    #
    # bind the combobox to entry
    #
    entry = Gtk::Entry.new
    combo.bind_property("active-id",entry,"text",GObject::BindingFlags::Bidirectional)
    box.append(entry)
  end

  def is_capital_sensitive(cell_layout : Gtk::CellLayout, cell : Gtk::CellRenderer, tree_model : Gtk::TreeModel,iter : Gtk::TreeIter, data : Pointer(Void))
    sensitive      = tree_model.iter_has_child(iter)
    # not the inversion
    cell.sensitive = !sensitive
  end

  def set_sensitive(cell_layout : Gtk::CellLayout, cell : Gtk::CellRenderer, tree_model : Gtk::TreeModel,iter : Gtk::TreeIter, data)
  end

  def row_separator
  end

  def fill_combo1()
    combo = Gtk::ComboBoxText.new_with_entry
    combo.append_text("One")
    combo.append_text("Two")
    combo.append_text("2\302\275")
    combo.append_text("Three")
    combo
  end

  def fill_combo2()
    combo = Gtk::ComboBoxText.new
    combo.append("never","Not visible")
    combo.append("when-active","Visible when active")
    combo.append("always", "Always visible")
    combo
  end

  def create_icon_store() : Gtk::TreeModel

    icon_names = ["dialog-warning", "process-stop","document-new",  "edit-clear", "", "document-open"]
    labels     = ["Warning", "Stop", "New", "Clear", "", "Open"]

    #
    # Create a store with 2 columns
    # to hold the icon names and their labels
    #
    store = Gtk::ListStore.new(GObject::TYPE_STRING, GObject::TYPE_STRING)
    (0..icon_names.size-1).each do |i|

      if icon_names[i] != ""
        #
        # create a new row
        #
        iter = store.append()
        #
        # set the data for this row and column
        #
        store.set_value(iter, 0, icon_names[i])
        store.set_value(iter, 1, labels[i])
      end

      # if icon_names[i] == ""
      #    iter = store.append()
      #    store.set_value(iter, 0, "")
      #    store.set_value(iter, 1, "")
      # end

    end

    return store.as(Gtk::TreeModel)
  end

  def create_capital_store() : Gtk::TreeModel
    capitals = Capitals.new()
    store    = Gtk::TreeStore.new(GObject::TYPE_STRING)
    iter1    = Gtk::TreeIter.new

    (0..capitals.size - 1).each do |i|

      capital = capitals.get_capital(i)
      if capital.group != ""
        #
        # create a new row
        #
        parent = nil
        iter1  = store.append(parent)
        store.set_value(iter1, 0, capital.group)

      elsif capital.name != ""
        #
        # create a new row
        #
        iter2 = store.append(iter1)
        store.set_value(iter2, 0, capital.name)
      end
    end

    return store.as(Gtk::TreeModel)
  end
end

exit(Lesson006.new.run)
