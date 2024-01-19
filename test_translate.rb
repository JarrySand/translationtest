# test_translate.rb

require_relative 'translate'

# Simulate command line input
input_args = ARGV

# Simulate meta information (you can customize this)
meta = {
  server_id: 'test_server_id',
}

# Call the translation function
result = Translate.call(input_args, meta)

# Display the result
puts result