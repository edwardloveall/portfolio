module S3
  BUCKET_NAME = 'el-experiments'.freeze
  DELIMITER = '/'.freeze
  AWS_BASE_URL = "http://#{BUCKET_NAME}.s3.amazonaws.com".freeze
end
