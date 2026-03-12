locals {
  image_url = "https://${yandex_storage_bucket.images_bucket.bucket_domain_name}/${yandex_storage_object.image.key}"
}

# Создание симметричного ключа шифрования
resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-encryption-key"
  description       = "Key for bucket encryption"
  default_algorithm = "AES_128"
  rotation_period   = "24h"  # Для учебных целей
}

# Вывод ID ключа
output "kms_key_id" {
  description = "ID of the KMS key for bucket encryption"
  value       = yandex_kms_symmetric_key.bucket_key.id
}
