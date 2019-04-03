project = Project.find_by_full_path('ionia/symbiotecostume')

Group.all.each do |group|
  project.project_group_links.create(
    group: group,
    group_access: 30, # adding as developer
    expires_at: nil
  )
end; :ok
