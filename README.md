### In this lab, we will set up a production Vault server using HashiCorp Vault. The steps below will guide you through the process of installing, configuring, and running a Vault server. We'll also cover enabling audit logging and accessing the Vault UI.

## Prerequisites
### Install Visual Studio Code (Optional but recommended for editing configuration files).

### Vault binary installed. You can download it from the official Vault website.

### A Unix-based system (Linux or macOS) or Windows with WSL.

### Lab Steps
## 1. Create the Vault Configuration File
### Create a file named vault-config.hcl with the following content:

nginx

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
}

storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

disable_mlock = true
api_addr = "http://localhost:8200"
cluster_addr = "http://127.0.0.1:8201"
ui = true

### Listener: Listens on all addresses at port 8200 with TLS disabled for demo purposes.

### Storage: Uses the Raft backend with data stored in ./vault/data and a node ID of node1.

### API & Cluster Address: Defines Vault's API and cluster address.

### UI: Enables the Vault UI.

## 2. Start the Vault Server
### In the terminal, navigate to the lab directory, create the storage directory, and start the Vault server:

bash
cd Section06-Starting_a_Production_Vault_Server
mkdir -p vault/data
vault server -config=./vault-config.hcl
This will start Vault and display logs with the API and cluster addresses.

## 3. Initialize the Vault Server
### In a new terminal tab, set the VAULT_ADDR environment variable to the Vault address:

arduino
export VAULT_ADDR=http://localhost:8200
Now, initialize the Vault server with the following command:

vbnet
vault operator init -key-shares=1 -key-threshold=1
This will generate an unseal key and a root token. Save these for later use.

### Set the VAULT_TOKEN environment variable to the root token:

arduino
export VAULT_TOKEN=<root_token>
Note: Replace <root_token> with the actual root token returned from the initialization step.

## 4. Unseal Vault
### Unseal the Vault server by providing the unseal key:

cpp
vault operator unseal

### Vault should now be unsealed. You can check the status with:

lua
vault status
It should show that "Initialized" is true and "Sealed" is false.

### You can also log in to the Vault UI using your root token at http://127.0.0.1:8200.

## 5. Enable Audit Logging
### Create a directory for logs and enable audit logging:

bash
mkdir logs
vault audit enable file file_path=./logs/vault_audit.log

### This command enables the file audit device. Now, you can monitor the Vault activities through the logs.
#To view the logs, open a third terminal and run:

bash
tail -f ./logs/vault_audit.log | jq

## 6. Access the Vault UI
### Open a web browser and navigate to http://127.0.0.1:8200. Use your root token to log in.
