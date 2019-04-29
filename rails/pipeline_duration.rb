# Total Pipeline and Last 5 Pipeline's Duration
Project.all.each do |project|
  next if project.ci_pipelines.empty?

  list = project.ci_pipelines.map(&:duration).compact
  next if list.empty? # No pipelines

  avg = list.reduce(:+).to_f / list.size

  list = project.ci_pipelines.order(:created_at).last(5).map(&:duration).compact
  last_avg = list.reduce(:+).to_f / list.size
  puts "#{project.full_name}(#{project.id})"
  puts "  Avg: #{avg.round(2)}, Last 5: #{last_avg.round(2)}"
end; :ok

# =============================================================================

# Sorted Total Pipeline and Queued Duration
list = Project.all.map do |project|
  next if project.ci_pipelines.empty?

  total = project.ci_pipelines.map(&:duration).compact
  queued = project.ci_pipelines.map(&:queued_duration).compact
  next if total.empty? # No pipelines

  total_avg = total.reduce(:+).to_f / total.size
  queued_avg = queued.reduce(:+).to_f / queued.size
  [
    project.full_name,
    project.id,
    queued_avg,
    total_avg,
  ]
end.compact; :ok

# Print sorted list
list.sort_by(&:last).each do |name, id, queue, total|
  puts "#{name}(#{id})"
  puts "  Avg: #{total.round(2)}, Queued 5: #{queue.round(2)}"
end; :ok
