begin

  kafka = Kafka.new(seed_brokers: ["localhost:9092"], client_id: "example")
  @guid = SecureRandom.uuid
  producer = kafka.producer

  avro = AvroTurf::Messaging.new(registry_url: "http://localhost:8081/")
  value = avro.encode({ "description" => "Example", "tables" => ["table1", "table2", "table3"] }, schema_name: "value")
  key = avro.encode({"key"=> @guid}, schema_name: "key")
  producer.produce(value, key: key, topic: "example")
  producer.deliver_messages

rescue => e

  puts e.to_s

end

