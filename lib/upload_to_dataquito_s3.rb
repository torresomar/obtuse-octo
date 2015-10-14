require 'aws-sdk'
require 'yaml'

# configure aws-sdk gem from a yaml configuration file
config = YAML.load_file('../config.yaml')

s3 = Aws::S3::Resource.new(
  region:'us-west-2',
  access_key_id: config[:access_key_id],
  secret_access_key: config[:secret_access_key]
)

bucket_name = config[:bucket_name]
bucket_path = config[:bucket_path]
bucket = s3.bucket(bucket_name)

Dir.glob('../data/*.json').each do |file| 
  name = File.basename file
  path = File.path file
  obj = bucket.object(bucket_path + name)
  obj.upload_file(path, {acl: 'public-read', content_type: 'application/json'})
end
