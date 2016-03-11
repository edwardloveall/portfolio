module S3
  Struct.new('Object', :key)
  Struct.new('CommonPrefix', :prefix)
  Struct.new('Response', :contents, :common_prefixes)

  def s3_response(hash = {})
    objects = hash[:contents].map do |object|
      Struct::Object.new(object)
    end

    prefixes = hash[:common_prefixes].map do |prefix|
      Struct::CommonPrefix.new(prefix)
    end

    Struct::Response.new(objects, prefixes)
  end

  def stub_s3(s3_structure, prefix: nil)
    response = s3_response(s3_structure)
    client = double(:client)
    if prefix.present?
      allow(client).
        to receive(:list_objects).
          with(hash_including(prefix: prefix)).
          and_return(response)
    else
      allow(client).to receive(:list_objects).and_return(response)
    end
    allow(Aws::S3::Client).to receive(:new).and_return(client)
  end
end
