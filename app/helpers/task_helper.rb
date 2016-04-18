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

    unless task.parent_id
      path = completed_task_path(task, complete: uncompleted)
    else
      path = completed_task_subtask_path(task.parent_id, task, complete: uncompleted)
    end

    icon_class = uncompleted ? options[:icon_uncompleted] : options[:icon_completed]

    icon = content_tag :span, '', "aria-hidden" => "true", class: icon_class
    link_to icon, path, method: :patch, remote: true, class: 'btn btn-default btn-sm'
  end

  def mark_privacy_button_to(task)
    active_class = task.is_private ? 'active' : ''

    icon = content_tag :span, '', "aria-hidden" => "true", class: 'glyphicon glyphicon-lock'
    link_to icon, privacy_task_path(task, private: !task.is_private),
      method: :patch, remote: true,
      class: 'btn btn-warning btn-sm ' + active_class
  end

  def inverse_filter(filter)
    filter == 1 ? 0 : 1
  end

  def link_filter_tasks(title, filter = {})
    filtered = filter.values[0]

    if filtered == 1
      active_class = 'active'
      filter[filter.keys[0]] = 0
    else
      active_class = ''
      filter[filter.keys[0]] = 1
    end
    # pry
    # span = content_tag :span, count.to_i, class: 'badge'
    # link = link_to title.to_s.html_safe << span, tasks_path(filter), remote: true
    link = link_to title, tasks_path(filter), remote: true

    li = "<li role='presentation' class='" + active_class + "'>" + link + "</li>"
    li.html_safe
  end
end
