json.extract! task, :id, :work, :finished, :created_at, :updated_at
json.url task_url(task, format: :json)