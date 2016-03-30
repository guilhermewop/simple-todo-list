class Task < ActiveRecord::Base
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Task"
  # validates_presence_of :title
  scope :only_public_tasks, -> { where(public: true) }
  scope :only_parent, -> { where(parent: nil) } # not include subtasks

  def private?
    self.public != true
  end

  def completed?
    self.completed != nil
  end

  def self.most_recent
    order(created_at: :desc)
  end
end
