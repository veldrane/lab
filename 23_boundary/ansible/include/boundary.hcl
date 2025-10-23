controller {
  name = "boundary-controller"
  disable_clustering = true
  database {
    url = "postgresql://boundary:password@localhost:5432/boundary?sslmode=disable"
  }
}

# Konfigurace Workeru
worker {
  name = "boundary-worker"
  controller {
    name = "boundary-controller"
    address = "127.0.0.1:9200"
  }
}

# Listener pro API a Worker
listener {
  purpose = "api"
  type = "tcp"
  tls_disable = true
  address = "0.0.0.0:9200"
}

listener {
  purpose = "proxy"
  type = "tcp"
  address = "0.0.0.0:9201"
}

listener {
  purpose = "cluster"
  type    = "tcp"
  address = "127.0.0.1:9202"
}

# Šifrování (můžete použít Vault pro generování klíčů)
kms "aead" {
  purpose = "root"
  aead_type = "aes-gcm"
  key = "0123456789abcdef0123456789abcdef"
}

kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "0123456789abcdef0123456789abcdef"
}
