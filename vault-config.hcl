listener "tcp" {
 address = "0.0.0.0:8200"
 tls_disable = true
}

storage "raft" {
  path = "./vault/data"
  node_id = "node1"
}

# Vault uses mlock to prevent memory from being swapped to disk. In prod environments you should not disable mlock.
disable_mlock = true

api_addr = "http://localhost:8200"
cluster_addr = "http://127.0.0.1:8201"
ui = true
