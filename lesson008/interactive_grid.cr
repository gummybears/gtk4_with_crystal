#
# interactive_grid.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
class InteractveGrid < Gtk::Widget
  property parent  : Gtk::Widget
  property button1 : Gtk::Button
  property button2 : Gtk::Button
  property button3 : Gtk::Button
  property guide   : Gtk::ConstraintGuide = Gtk::ConstraintGuide.new
  property manager : Gtk::ConstraintLayout
  property constraint : Gtk::Constraint = Gtk::Constraint.new

  property x        : Float64 = 0.0
  property y        : Float64 = 0.0
  property offset_x : Float64 = 0.0
  property offset_y : Float64 = 0.0

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

    @guide      = Gtk::ConstraintGuide.new
    @guide.name = "space"
    @guide.set_min_size(10, 10)
    @guide.set_nat_size(100, 10)
    @guide.set_max_size(200, 20)
    @guide.strength = Gtk::ConstraintStrength::Strong
    @manager.add_guide(guide)

    constraints()

    parent.append(@button1)
    parent.append(@button2)
    parent.append(@button3)

    drag = Gtk::GestureDrag.new
    drag.drag_begin_signal.connect(->drag_begin_callback(Float64,Float64))
    drag.drag_update_signal.connect(->drag_update_callback(Float64,Float64))
    drag.drag_end_signal.connect(->drag_begin_callback(Float64,Float64))

    # do
    #  puts "drag update"
    #  layout = @manager
    #  flag = drag.start_point(x,y)
    #
    #  constraint = Gtk::Constraint.new_constant(
    #                                           @guide,
    #                                           Gtk::ConstraintAttribute::Left,
    #                                           Gtk::ConstraintRelation::Eq,
    #                                           x + offset_x,
    #                                           Gtk::ConstraintStrength::Required.to_i32
    #                                           )
    #  layout.add_constraint(constraint)
    #  parent.queue_allocate
    #end

    parent.add_controller(drag)
  end

  def drag_begin_callback(x : Float64, y : Float64)
    puts "drag begin : x #{x} y #{y}"
    @x = x
    @y = y
  end

  def drag_update_callback(x : Float64, y : Float64)
    puts "drag update : x #{x} y #{y}"
    @offset_x = x
    @offset_y = y
    #@x     = x
    #@y     = y
    layout = @manager

    #if @constraint
    #  layout.remove_constraint(@constraint)
    #else
      @constraint = Gtk::Constraint.new_constant(
                                              @guide,
                                              Gtk::ConstraintAttribute::Left,
                                              Gtk::ConstraintRelation::Eq,
                                              @x + @offset_x,
                                              Gtk::ConstraintStrength::Required.to_i32
                                              )
      layout.add_constraint(@constraint)
    #end
    @parent.queue_allocate
  end

  def drag_end_callback(x : Float64, y : Float64)
    puts "drag end : x #{x} y #{y}"
    @x = x
    @y = y
  end

  def constraints()

    relation   = Gtk::ConstraintRelation::Eq
    constraint = Gtk::Constraint.new_constant(
                        @guide,
                        Gtk::ConstraintAttribute::Width,
                        relation,
                        0.0,
                        Gtk::ConstraintStrength::Required.to_i32
                        )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                     nil,
                                     Gtk::ConstraintAttribute::Start,
                                     relation,
                                     @button1,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                      @button1,
                                      Gtk::ConstraintAttribute::End,
                                      relation,
                                      @guide,
                                      Gtk::ConstraintAttribute::Start,
                                      1.0,
                                      0.0,
                                      Gtk::ConstraintStrength::Required.to_i32
                                      )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button2,
                                    Gtk::ConstraintAttribute::Start,
                                    relation,
                                    @guide,
                                    Gtk::ConstraintAttribute::End,
                                    1.0,
                                    0.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button2,
                                    Gtk::ConstraintAttribute::End,
                                    relation,
                                    nil,
                                    Gtk::ConstraintAttribute::End,
                                    1.0,
                                    -8.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    nil,
                                    Gtk::ConstraintAttribute::Start,
                                    relation,
                                    @button3,
                                    Gtk::ConstraintAttribute::Start,
                                    1.0,
                                    -8.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button3,
                                    Gtk::ConstraintAttribute::End,
                                    relation,
                                    @guide,
                                    Gtk::ConstraintAttribute::Start,
                                    1.0,
                                    0.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    nil,
                                    Gtk::ConstraintAttribute::Top,
                                    relation,
                                    @button1,
                                    Gtk::ConstraintAttribute::Top,
                                    1.0,
                                    -8.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )

    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button2,
                                    Gtk::ConstraintAttribute::Top,
                                    relation,
                                    @button1,
                                    Gtk::ConstraintAttribute::Bottom,
                                    1.0,
                                    0.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button3,
                                    Gtk::ConstraintAttribute::Top,
                                    relation,
                                    @button2,
                                    Gtk::ConstraintAttribute::Bottom,
                                    1.0,
                                    0.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )

    @manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button3,
                                    Gtk::ConstraintAttribute::Bottom,
                                    relation,
                                    nil,
                                    Gtk::ConstraintAttribute::Bottom,
                                    1.0,
                                    -8.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    @manager.add_constraint(constraint)
  end
end
