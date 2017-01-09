class Task < ActiveRecord::Base

  has_many :subtasks, :class_name => "Task", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_task, :class_name => "Task"

  def percent_finished
    ((subtasks.where(:finished => true).count) * 100) / (subtasks.count)
  end
end
