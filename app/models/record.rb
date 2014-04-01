class Record < AWS::Record::HashModel
  string_attr :id, :hash_key => true
  string_attr :read_permission
  string_attr :write_permission
  string_attr :value
  timestamps
end