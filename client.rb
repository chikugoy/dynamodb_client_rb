require 'aws-sdk-dynamodb'
require 'concurrent'

client = Aws::DynamoDB::Client.new(
  region: 'ap-northeast-1',
  access_key_id: 'dummy',
  secret_access_key: 'dummy'
)

item_count = 1000
batch_size = 25

# DynamoDBにデータを投入するメソッド
def write_to_dynamodb(client, chunk)
  requests = chunk.map do |i|
    { put_request: { item: { "id" => i.to_s, "sort" => "SortKeyValue" } } }
  end

  client.batch_write_item(request_items: { 'books' => requests })
end

start_time = Time.now

# データをバッチに分割して並列処理
futures = (0...item_count).each_slice(batch_size).map do |chunk|
  Concurrent::Future.execute { write_to_dynamodb(client, chunk) }
end

# すべてのタスクが完了するのを待つ
futures.each(&:wait)

end_time = Time.now
puts "Execution time: #{end_time - start_time} seconds"
