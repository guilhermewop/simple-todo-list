module TaskHelper

  def privacity_class(task)
    'active' if task.is_public?
  end

  def mark_as_completed_button_to(task, options = {})
    completed = !task.is_completed?

    icon_class = completed ? options[:icon_uncompleted] : options[:icon_completed]

    icon = content_tag :span, '', "aria-hidden" => "true", class: icon_class
    link_to icon, completed_task_path(task, complete: completed), method: :patch, remote: true, class: 'btn btn-default btn-sm'
  end

  def mark_privacy_button_to(task)
    is_public = task.is_public?

    active_class = is_public ? '' : 'active'

    icon = content_tag :span, '', "aria-hidden" => "true", class: 'glyphicon glyphicon-lock'
    link_to icon, privacy_task_path(task, private: is_public),
      method: :patch, remote: true,
      class: 'btn btn-warning btn-sm ' + active_class
  end
end
