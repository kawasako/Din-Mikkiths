class Task < AWS::Record::HashModel
  string_attr :id, :hash_key => true
  string_attr :name
  timestamps
end