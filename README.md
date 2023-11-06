### Gtk4 tutorial

Based on the website https://toshiocp.github.io/Gtk4-tutorial/sec7.html
and Gtk4 demos

#### Contents
- lesson 001 : Application Class
- lesson 002 : Assistant
- lesson 003 : Colors
- lesson 004 : Builder
- lesson 005 : Clipboard
               status : paste method not finished

- lesson 006 : Comboboxes
               status : MaskEntry not implemented

- lesson 007 : Simple Constraints
- lesson 008 : Interactive Constraints
               status : drag method using callbacks
- lesson 009 : Constraints using Visual Format Language
               status : not sure about the call to add_constraints_from_description
- lesson 010 : Constraints using Gtk::Builder
- lesson 011 : Cursors
- lesson 012 : Dialogs

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
