### Gtk4 tutorial

Based on the website https://toshiocp.github.io/Gtk4-tutorial/sec7.html
and Gtk4 demos

#### Contents
- lesson 001 : Application Class

  - Demonstrates a simple application.
    This example uses Gtk::Application, Gtk::ApplicationWindow, Gtk::Builder as well as GMenu and GResource.
    Due to the way Gtk::Application is structured, it is run as a separate process.

- lesson 002 : Assistant

  - Demonstrates a sample multi-step assistant with Gtk::Assistant. Assistants are used to divide
    an operation into several simpler sequential steps, and to guide the user through these steps.

- lesson 003 : Colors

  - This demo is intentionally as simple as possible, to see what framerate the windowing system can
    deliver on its own. It does nothing but change the drawn color, for every frame.

- lesson 004 : Builder

  - Demonstrates a traditional interface, loaded from a XML description, and shows how to connect
    actions to the menu items and toolbar buttons.

- lesson 005 : Clipboard

  - Gdk::Clipboard is used for clipboard handling. This demo shows how to copy and paste text,
    images, colors or files to and from the clipboard. You can also use Drag-And-Drop
    to copy the data from the source to the target.

    status : paste method not finished

- lesson 006 : Comboboxes

  - The Gtk::ComboBox widget allows to select one option out of a list. The Gtk::ComboBoxEntry additionally allows
    the user to enter a value that is not in the list of options. How the options are displayed
    is controlled by cell renderers.

    status : MaskEntry not implemented

- lesson 007 : Simple Constraints

  - Gtk::ConstraintLayout provides a layout manager that uses relations between widgets (also known as “constraints”)
    to compute the position and size of each child. In addition to child widgets, the constraints can involve spacer objects
    (also known as “guides”). This example has a guide between the two buttons in the top row.
    Try resizing the window to see how the constraints react to update the layout.

- lesson 008 : Interactive Constraints

  - This example shows how constraints can be updated during user interaction. The vertical edge between the buttons
    can be dragged with the mouse.

    status : drag method using callbacks

- lesson 009 : Constraints using Visual Format Language

  - Gtk::ConstraintLayout allows defining constraints using a compact syntax called Visual Format Language, or VFL.
    A typical example of a VFL specification looks like this:
    H:|-[button1(==button2)]-12-[button2]-|

    status : not sure about the call to add_constraints_from_description

- lesson 010 : Constraints using Gtk::Builder

  - Gtk::ConstraintLayouts can be created in .ui files, and constraints can be set up at that time as well,
    as this example demonstrates. It shows various ways to do spacing and sizing with constraints.
    Make the window wider to see the rows react differently

- lesson 011 : Cursors

  - Demonstrates a useful set of available cursors. The cursors shown here are the ones defined by CSS,
    which we assume to be available. The example shows creating cursors by name or from an image,
    with or without a fallback.

- lesson 012 : Dialogs

  - Dialogs are used to pop up transient windows for information and user feedback.

- lesson 013 : Drag and Drop

  - This demo shows dragging colors and widgets. The items in this demo can be moved, recolored and rotated.
    The demo also has an example for creating a menu-like popover without using a menu model.

To run the code for a lesson, go to
corresponding directory. Make sure
the script build.sh is executable and then
execute the following commands from
your terminal

````
$ shards install
$ ./bin/gi-crystal
$ ./build.sh
$ ./a.out
````
The build.sh script will compile and link a lesson
and produces the executable a.out
