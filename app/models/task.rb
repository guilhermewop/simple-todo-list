class Task < ActiveRecord::Base
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id", dependent: :delete_all
  belongs_to :parent, class_name: "Task"
  belongs_to :user

  default_scope { order(updated_at: :desc, completed_at: :asc) }
  scope :shared, -> { where(is_private: false) }
  scope :only_parent, -> { where(parent: nil) } # not include subtasks

  validates :title, presence: true
  validates :user, presence: true

  def is_completed?
    self.completed_at != nil
  end

  # def self.most_recent
  #   order(created_at: :desc)
  # end
end
