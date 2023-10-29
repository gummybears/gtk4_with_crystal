#
# main.cr
#
# author : W.F.F. Neimeijer
# copyright 2007-2023, ICUBIC
#
require "gtk4"

class SimpleGrid < Gtk::Widget

  #property parent  : Gtk::Widget = Gtk::Widget.new
  property button1 : Gtk::Button
  property button2 : Gtk::Button
  property button3 : Gtk::Button

  def initialize(parent)

    # need to call super
    super()

    #@parent  = parent
    @button1 = Gtk::Button.new_with_label("Child 1")
    @button2 = Gtk::Button.new_with_label("Child 2")
    @button3 = Gtk::Button.new_with_label("Child 3")

    #button1.parent = self
    #button2.parent = self
    #button3.parent = self

    #manager = self.layout_manager
    #build_constraints(manager.as(Gtk::ConstraintLayout))
    #manager = self.as(Gtk::Widget).layout_manager.as(Gtk::ConstraintLayout)
    #manager = @parent.layout_manager
    #manager = self.layout_manager #@parent.layout_manager
    #manager = self.as(Gtk::Widget).layout_manager

    manager = Gtk::ConstraintLayout.new
    puts "manager #{manager.class}"
    if manager
      # manager = manager.not_nil!.as(Gtk::ConstraintLayout)
      build_constraints(manager)
    end
  end

  def build_constraints(manager : Gtk::ConstraintLayout) #(manager)
    #manager = self.as(Gtk::Widget).layout_manager.as(Gtk::ConstraintLayout)
    #manager = @parent.layout_manager

    #manager = @parent.layout_manager
    #puts "manager #{@parent.layout_manager.class}"
    #if manager
    #manager = manager.not_nil!.as(Gtk::ConstraintLayout)
    #puts "manager #{manager}"

    guide = Gtk::ConstraintGuide.new
    guide.name = "space"
    guide.set_min_size(10, 10)
    guide.set_nat_size(100, 10)
    guide.set_max_size(200, 20)
    guide.strength = Gtk::ConstraintStrength::Strong

    # does not compile manager.add_guide(guide)

    # enum ConstraintAttribute : UInt32
    #   None     =  0
    #   Left     =  1
    #   Right    =  2
    #   Top      =  3
    #   Bottom   =  4
    #   Start    =  5
    #   End      =  6
    #   Width    =  7
    #   Height   =  8
    #   CenterX  =  9
    #   CenterY  = 10
    #   Baseline = 11
    # end

    # Less Equal constraint
    relation = Gtk::ConstraintRelation::Le
    constraint1 = Gtk::Constraint.new_constant(
                                              @button1.as(Gtk::ConstraintTarget),
                                              Gtk::ConstraintAttribute::Width,
                                              relation,
                                              200.0,
                                              Gtk::ConstraintStrength::Required.to_i32
                                              )

    manager.add_constraint(constraint1)

    # Equal constraint
    relation = Gtk::ConstraintRelation::Eq
    constraint2 = Gtk::Constraint.new(
                                     nil,
                                     Gtk::ConstraintAttribute::Start,
                                     relation,
                                     @button1,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint2)

    relation = Gtk::ConstraintRelation::Eq
    constraint3 = Gtk::Constraint.new(
                                     @button1,
                                     Gtk::ConstraintAttribute::Width,
                                     relation,
                                     @button2,
                                     Gtk::ConstraintAttribute::Width,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint3)

    relation = Gtk::ConstraintRelation::Eq
    constraint4 = Gtk::Constraint.new(
                                     @button1,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     guide,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint4)


    relation = Gtk::ConstraintRelation::Eq
    constraint5 = Gtk::Constraint.new(
                                     guide,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     @button2,
                                     Gtk::ConstraintAttribute::Start,
                                     1.0,
                                     0.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint5)

    relation = Gtk::ConstraintRelation::Eq
    constraint6 = Gtk::Constraint.new(
                                     @button2,
                                     Gtk::ConstraintAttribute::End,
                                     relation,
                                     nil,
                                     Gtk::ConstraintAttribute::End,
                                     1.0,
                                     -8.0,
                                     Gtk::ConstraintStrength::Required.to_i32
                                     )
    manager.add_constraint(constraint6)

  end
end


class Lesson007 < Gtk::Application

  def initialize()
    super(application_id: "constraints.example.com", flags: Gio::ApplicationFlags::HandlesOpen)
  end

  @[GObject::Virtual]
  def activate

    window = Gtk::Window.new
    window.set_default_size(260,-1)
    window.title = "Simple Constraints"

    box = Gtk::Box.new(orientation: :vertical,spacing: 12)
    #window.child = box

    grid = SimpleGrid.new(box) #box)
    grid.hexpand = true
    grid.vexpand = true
    box.append(grid)

   #  grid = g_object_new ( (), NULL);
   #  gtk_widget_set_hexpand (grid, TRUE);
   #  gtk_widget_set_vexpand (grid, TRUE);
   #  gtk_box_append (GTK_BOX (box), grid);


    window.child = box
    window.application = self
    window.present
  end

end

exit(Lesson007.new.run)
