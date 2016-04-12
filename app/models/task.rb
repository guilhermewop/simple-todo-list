class Task < ActiveRecord::Base
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id", dependent: :delete_all
  belongs_to :parent, class_name: "Task"
  belongs_to :user

  validates :title, presence: true
  validates :user, presence: true

  scope :only_public_tasks, -> { where(public: true) }
  scope :only_parent, -> { where(parent: nil) } # not include subtasks

  def is_completed?
    self.completed_at != nil
  end

  def self.most_recent
    order(created_at: :desc)
  end
end
