class TextEditor
  property filename : String
  property basename : String
  property notebook : Gtk::Notebook
  property modified : Bool = false

  def initialize(filename : String, notebook : Gtk::Notebook)
    @filename = filename

    if @filename =~ /untitled/
      @basename = @filename
    else
      @basename = File.basename(filename)
    end

    @notebook = notebook
  end

  @[GObject::Virtual]
  def activate
  end

  def read_file(filename : String) : String
    s = File.read_lines(filename).join("\n")
    return s
  end

  def add()
    scrolled_window    = Gtk::ScrolledWindow.new
    textview           = Gtk::TextView.new

    textbuffer = textview.buffer
    if @basename =~ /untitled/
      textbuffer.text = ""
    else
      textbuffer.text = read_file(@basename)
    end

    textview.wrap_mode    = Gtk::WrapMode::WordChar
    scrolled_window.child = textview

    #
    # create a page with empty content
    #
    label = Gtk::Label.new(@basename)
    if @basename !~ /untitled/
      label = Gtk::Label.new(File.basename(@basename))
    end

    #
    # append scrolled window to notebook
    #
    page_index = @notebook.append_page(scrolled_window,label)

    #
    # expand the tabs
    #
    notebook_page = @notebook.page(scrolled_window)
    notebook_page.tab_expand = true
    #notebook_page.clicked_signal.connect do
    #  puts "clicked on page"
    #end

    #
    # set the notebook's current page
    #
    @notebook.current_page = page_index

    # old code if @basename !~ /untitled/
    # old code   #
    # old code   # when we edit the file, ie  the textview changes we need to know about it
    # old code   # only for the files we opened
    # old code   #
    # old code   textbuffer.changed_signal.connect do
    # old code     @modified  = true
    # old code     label.text = @basename + "(*)"
    # old code   end
    # old code end

    #
    # when we edit the file, ie  the textview changes we need to know about it
    # only for the files we opened
    #
    textbuffer.changed_signal.connect do
      @modified  = true
      label.text = @basename + "(*)"
    end
  end

  def get_textview : Gtk::TextView
    page_index      = @notebook.current_page
    scrolled_window = Gtk::ScrolledWindow.cast(@notebook.nth_page(page_index))
    textview        = Gtk::TextView.new
    if scrolled_window
      textview = Gtk::TextView.cast(scrolled_window.child)
    end
    return textview
  end

  def save_file(filename : String)
    contents   = ""
    textview   = get_textview()
    textbuffer = textview.buffer

    if textbuffer.modified
      @modified = false
      contents = textbuffer.text

      if File.exists?(filename)
        file = File.open(filename,"w")
        file.puts contents
        file.close
      else
        # new file
        file = File.new(filename,"w")
        file.puts contents
        file.close
      end

      page_index = @notebook.current_page

      #label = Gtk::Label.cast(@notebook.nth_page(page_index))
      #if label
      #  @filename  = filename
      #  @basename  = File.basename(filename)
      #  label.text = @basename
      #end
      # @notebook.set_label_text = File.basename(filename)

    end
  end
end
