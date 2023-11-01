#
# interactive_grid.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
class InteractveGrid < Gtk::Widget

  property button1 : Gtk::Button
  property button2 : Gtk::Button
  property button3 : Gtk::Button

  def initialize(parent)

    @button1 = Gtk::Button.new_with_label("Child 1")
    @button2 = Gtk::Button.new_with_label("Child 2")
    @button3 = Gtk::Button.new_with_label("Child 3")
    @button1.name = "button1"
    @button2.name = "button2"
    @button3.name = "button3"

    manager =  Gtk::ConstraintLayout.new
    parent.layout_manager = manager
    constraints(manager,@button1,@button2,@button3)

    parent.append(@button1)
    parent.append(@button2)
    parent.append(@button3)
  end

  def constraints(manager,button1,button2,button3)

    guide      = Gtk::ConstraintGuide.new
    guide.name = "space"

    guide.set_min_size(10, 10)
    guide.set_nat_size(100, 10)
    guide.set_max_size(200, 20)
    guide.strength = Gtk::ConstraintStrength::Strong
    manager.add_guide(guide)

    relation   = Gtk::ConstraintRelation::Eq
    constraint = Gtk::Constraint.new_constant(
                        guide,
                        Gtk::ConstraintAttribute::Width,
                        relation,
                        0.0,
                        Gtk::ConstraintStrength::Required.to_i32
                        )
    manager.add_constraint(constraint)

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
    manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                      @button1,
                                      Gtk::ConstraintAttribute::End,
                                      relation,
                                      guide,
                                      Gtk::ConstraintAttribute::Start,
                                      1.0,
                                      0.0,
                                      Gtk::ConstraintStrength::Required.to_i32
                                      )
    manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button2,
                                    Gtk::ConstraintAttribute::Start,
                                    relation,
                                    guide,
                                    Gtk::ConstraintAttribute::End,
                                    1.0,
                                    0.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    manager.add_constraint(constraint)

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
    manager.add_constraint(constraint)

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
    manager.add_constraint(constraint)

    constraint = Gtk::Constraint.new(
                                    @button3,
                                    Gtk::ConstraintAttribute::End,
                                    relation,
                                    guide,
                                    Gtk::ConstraintAttribute::Start,
                                    1.0,
                                    0.0,
                                    Gtk::ConstraintStrength::Required.to_i32
                                    )
    manager.add_constraint(constraint)

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

    manager.add_constraint(constraint)

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
    manager.add_constraint(constraint)

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

    manager.add_constraint(constraint)

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
    manager.add_constraint(constraint)
  end
end
