output "logs" {
  value = aws_s3_bucket.bucket_access_logs
}

output "bucket" {
  value = aws_s3_bucket.bucket
}
