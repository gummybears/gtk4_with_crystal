#
# simple_grid.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#

# Layout:
#
#   +-------------------------------------+
#   | +-----------++-------++-----------+ |
#   | |  Child 1  || Space ||  Child 2  | |
#   | +-----------++-------++-----------+ |
#   | +---------------------------------+ |
#   | |             Child 3             | |
#   | +---------------------------------+ |
#   +-------------------------------------+
#
# Constraints:
#
#   super.start = child1.start - 8
#   child1.width = child2.width
#   child1.end = space.start
#   space.end = child2.start
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
# To add some flexibility, we make the space
# stretchable:
#
#   space.width >= 10
#   space.width = 100
#   space.width <= 200
#

class SimpleGrid < Gtk::Widget

  property button1 : Gtk::Button
  property button2 : Gtk::Button
  property button3 : Gtk::Button

  def initialize(parent)

    @button1 = Gtk::Button.new_with_label("Child 1")
    @button2 = Gtk::Button.new_with_label("Child 2")
    @button3 = Gtk::Button.new_with_label("Child 3")

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

    # Less Equal constraint
    relation    = Gtk::ConstraintRelation::Le
    constraint1 = Gtk::Constraint.new_constant(
                                              button1.as(Gtk::ConstraintTarget),
                                              Gtk::ConstraintAttribute::Width,
                                              relation,
                                              200.0,
                                              Gtk::ConstraintStrength::Required.to_i32
                                              )

    manager.add_constraint(constraint1)

    # Equal constraint
    relation    = Gtk::ConstraintRelation::Eq
    constraint2 = Gtk::Constraint.new(
                                     nil,
                                     Gtk::ConstraintAttribute::Start,
                                     relation,
                                     button1,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint2)

    relation    = Gtk::ConstraintRelation::Eq
    constraint3 = Gtk::Constraint.new(
                                     button1,
                                     Gtk::ConstraintAttribute::Width,
                                     relation,
                                     button2,
                                     Gtk::ConstraintAttribute::Width,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint3)

    relation    = Gtk::ConstraintRelation::Eq
    constraint4 = Gtk::Constraint.new(
                                     button1,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     guide,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint4)


    relation    = Gtk::ConstraintRelation::Eq
    constraint5 = Gtk::Constraint.new(
                                     guide,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     button2,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint5)

    relation    = Gtk::ConstraintRelation::Eq
    constraint6 = Gtk::Constraint.new(
                                     button2,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     nil,
                                     Gtk::ConstraintAttribute::End,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint6)

    relation    = Gtk::ConstraintRelation::Eq
    constraint7 = Gtk::Constraint.new(
                                     nil,
                                     Gtk::ConstraintAttribute::Start,
                                     relation,
                                     button3,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint7)

    relation    = Gtk::ConstraintRelation::Eq
    constraint8 = Gtk::Constraint.new(
                                     button3,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     nil,
                                     Gtk::ConstraintAttribute::End,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint8)

    relation    = Gtk::ConstraintRelation::Eq
    constraint9 = Gtk::Constraint.new(
                                     nil,
                                     Gtk::ConstraintAttribute::Top,
                                     relation,
                                     button1,
                                     Gtk::ConstraintAttribute::Top,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint9)

    relation     = Gtk::ConstraintRelation::Eq
    constraint10 = Gtk::Constraint.new(
                                     nil,
                                     Gtk::ConstraintAttribute::Top,
                                     relation,
                                     button2,
                                     Gtk::ConstraintAttribute::Top,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint10)

    relation     = Gtk::ConstraintRelation::Eq
    constraint11 = Gtk::Constraint.new(
                                     button1,
                                     Gtk::ConstraintAttribute::Bottom,
                                     relation,
                                     button3,
                                     Gtk::ConstraintAttribute::Top,
                                     1.0,
                                     -12.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint11)

    relation     = Gtk::ConstraintRelation::Eq
    constraint12 = Gtk::Constraint.new(
                                     button2,
                                     Gtk::ConstraintAttribute::Bottom,
                                     relation,
                                     button3,
                                     Gtk::ConstraintAttribute::Top,
                                     1.0,
                                     -12.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint12)

    relation     = Gtk::ConstraintRelation::Eq
    constraint13 = Gtk::Constraint.new(
                                     button3,
                                     Gtk::ConstraintAttribute::Height,
                                     relation,
                                     button1,
                                     Gtk::ConstraintAttribute::Height,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint13)

    relation     = Gtk::ConstraintRelation::Eq
    constraint14 = Gtk::Constraint.new(
                                     button3,
                                     Gtk::ConstraintAttribute::Height,
                                     relation,
                                     button2,
                                     Gtk::ConstraintAttribute::Height,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint14)

    relation     = Gtk::ConstraintRelation::Eq
    constraint15 = Gtk::Constraint.new(
                                     button3,
                                     Gtk::ConstraintAttribute::Bottom,
                                     relation,
                                     nil,
                                     Gtk::ConstraintAttribute::Bottom,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint15)
  end
end
