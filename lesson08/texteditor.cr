class TextEditor
  property filename : String
  property basename : String
  property notebook : Gtk::Notebook

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

    if @basename !~ /untitled/
      #
      # when we edit the file, ie  the textview changes we need to know about it
      # only for the files we opened
      #
      textbuffer.changed_signal.connect do
        label.text = @basename + "(*)"
      end
    end
  end
end
