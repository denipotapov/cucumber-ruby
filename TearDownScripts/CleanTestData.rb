require 'mongo'

def delete_generated_statements(pins, days_untill, host, port, db_name, user, password)
  pins_as_hash = []
  pins.each {|pin| pins_as_hash << {'pinEq' => pin}}
  mongoClient = Mongo::Client.new([ "#{host}:#{port}" ], :database => db_name, :user => user, :password => password)
  result = mongoClient[:stmt_order].find({"$and" => [{"$or" => pins_as_hash}, {"createDate" => {"$lt": (Time.now - 3600 * 24 * days_untill).utc}}]})
  if result.count > 0 then
      result.each do |document|
      puts "Удаление справки с id: #{document['_id']}"
      end
    result.delete_many
  else
      puts "Нечего удалять"
  end
end