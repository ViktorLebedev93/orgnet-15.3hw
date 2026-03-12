# Бакет Object Storage с шифрованием
resource "yandex_storage_bucket" "images_bucket" {
  bucket     = "lebedev-vv-fops33-11-03-2026"
  acl        = "public-read"
  folder_id  = var.yc_folder_id

  # Добавляем шифрование с помощью KMS ключа
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Загрузка картинки в бакет
resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.images_bucket.id
  key    = "image.jpg"
  source = "files/image.jpg"
  acl    = "public-read"
  
  depends_on = [
    yandex_storage_bucket.images_bucket
  ]
}
