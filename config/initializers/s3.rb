s3Client = Aws::S3::Client.new(
  region: ENV['AWS_REGION'],
  access_key_id: ENV['ACCESS_KEY'],
  secret_access_key: ENV['SECRET_ACCESS_KEY']
)

$signer = Aws::S3::Presigner.new(client: s3Client)