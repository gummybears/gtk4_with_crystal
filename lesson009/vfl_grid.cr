#
# vfl_grid.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
# Layout:
#
#   +-----------------------------+
#   | +-----------+ +-----------+ |
#   | |  Child 1  | |  Child 2  | |
#   | +-----------+ +-----------+ |
#   | +-------------------------+ |
#   | |         Child 3         | |
#   | +-------------------------+ |
#   +-----------------------------+
#
# Constraints:
#
#   super.start = child1.start - 8
#   child1.width = child2.width
#   child1.end = child2.start - 12
#   child2.end = super.end - 8
#   super.start = child3.start - 8
#   child3.end = super.end - 8
#   super.top = child1.top - 8
#   super.top = child2.top - 8
#   child1.bottom = child3.top - 12
#   child2.bottom = child3.top - 12
#   child3.height = child1.height
#   child3.height = child2.height
#   child3.bottom = super.bottom - 8
#
# Visual format:
#
#   H:|-8-[view1(==view2)-12-[view2]-8-|
#   H:|-8-[view3]-8-|
#   V:|-8-[view1]-12-[view3(==view1)]-8-|
#   V:|-8-[view2]-12-[view3(==view2)]-8-|
#
class VflGrid < Gtk::Widget
  property parent  : Gtk::Widget
  property button1 : Gtk::Button
  property button2 : Gtk::Button
  property button3 : Gtk::Button
  property guide   : Gtk::ConstraintGuide = Gtk::ConstraintGuide.new
  property manager : Gtk::ConstraintLayout

  def initialize(parent)
    @parent  = parent
    @button1 = Gtk::Button.new_with_label("Child 1")
    @button2 = Gtk::Button.new_with_label("Child 2")
    @button3 = Gtk::Button.new_with_label("Child 3")
    @button1.name = "button1"
    @button2.name = "button2"
    @button3.name = "button3"

    @manager = Gtk::ConstraintLayout.new
    parent.layout_manager = @manager
    parent.append(@button1)
    parent.append(@button2)
    parent.append(@button3)

    hexpand = true
    vexpand = true
    constraints()
  end

  def constraints()

    vfl = [
        "H:|-[button1(==button2)]-12-[button2]-|",
        "H:|-[button3]-|",
        "V:|-[button1]-12-[button3(==button1)]-|",
        "V:|-[button2]-12-[button3(==button2)]-|",
      ]

    #views = uninitialized Pointer(Void)
    views = Pointer(Void).null
    list = @manager.add_constraints_from_description(vfl,8,8,views)
    #Pointer(Void).null) #views) #pointerof(views)) #Pointer(Void).null)
    puts "list #{list.class} size #{list.size}"
  end
end
