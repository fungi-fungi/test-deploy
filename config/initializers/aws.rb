Aws.config.update({
  region: ENV['S3_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})

SIGNER = Aws::S3::Presigner.new
S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])