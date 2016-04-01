module TaskHelper

  def form_title(task)
    task_type = !task.parent_id ? 'Task' : 'Subtask'
    title = task.new_record? ? "New #{task_type}" : "Editing #{task_type} \##{task.id}"
    title.html_safe
  end

  def form_action(task)
    path = !task.parent_id ? '/tasks' : "/tasks/#{task.parent_id}/subtasks"
    path = path + "/#{task.id}" unless task.new_record?
    path.to_s
  end

  def task_title(task)
    title = "##{task.id} #{task.title}"
    title = "<s>#{title}</s>" if task.is_completed?
    title.html_safe
  end

  def mark_as_completed_button_to(task, options = {})
    uncompleted = !task.is_completed?

    icon_class = uncompleted ? options[:icon_uncompleted] : options[:icon_completed]

    icon = content_tag :span, '', "aria-hidden" => "true", class: icon_class
    link_to icon, completed_task_path(task, complete: uncompleted), method: :patch, remote: true, class: 'btn btn-default btn-sm'
  end

  def mark_privacy_button_to(task)
    is_public = !task.is_private

    active_class = !is_public ? 'active' : ''

    icon = content_tag :span, '', "aria-hidden" => "true", class: 'glyphicon glyphicon-lock'
    link_to icon, privacy_task_path(task, private: is_public),
      method: :patch, remote: true,
      class: 'btn btn-warning btn-sm ' + active_class
  end
end
