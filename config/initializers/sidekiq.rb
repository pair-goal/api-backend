schedule_file = "config/schedule.yml"
if File.exist?(schedule_file)
  config = YAML.load(File.open(Rails.root.join(schedule_file))).symbolize_keys
  Sidekiq::Cron::Job.create config
end
Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
