require 'aws'

# log requests using the default rails logger
AWS.config(logger: Rails.logger,
           log_level: :info)

# load credentials from a file
config_path = File.expand_path(File.dirname(__FILE__)+"/../aws.yml")
AWS.config(YAML.load(File.read(config_path)))

#AWS::Record.table_prefix = 'myapp_'