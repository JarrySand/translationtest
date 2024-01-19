# frozen_string_literal: true

require 'net/http'
require 'json'

# Replace with your actual OpenAI API key
OPENAI_API_KEY = ENV['OPENAI_API_KEY']

module Translate
  def self.call(args, _meta)
    return help if args.empty? || args.first == 'help'

    text_to_translate = args.join(' ')

    # Make a POST request to the OpenAI API
    response = Net::HTTP.post(
      URI('https://api.openai.com/v1/chat/completions'),
      {
        "model": 'gpt-3.5-turbo', # Use the recommended model
        "messages": [
          { "role": "system", "content": "Translate the following English text to Japanese:" },
          { "role": "user", "content": text_to_translate }
        ],
        "max_tokens": 60
      }.to_json,
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{OPENAI_API_KEY}"
    )

    response_body = JSON.parse(response.body)

    if response_body['error'].nil?
      if response_body['choices'] && !response_body['choices'].empty?
        translated_text = response_body['choices'].first['message']['content']
        translated_text  # Return only the translated text
      else
        "Translation failed. Check the input and try again."
      end
    else
      "Error: #{response_body['error']['message']}"
    end
  rescue StandardError => e
    "An error occurred: #{e.message}"
  end

  def self.help
    # Help message explaining how to use the bot
    <<~TEXT
      bot が入力された英文を日本語に翻訳します。

      使い方:
        !translate [English script]
    TEXT
  end
end


