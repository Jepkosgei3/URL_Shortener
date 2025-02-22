#!/usr/bin/env bash
# Navigate to the Terraform directory
  cd terraform/

  # Ensure Terraform is initialized (usually done in the terraform stage, but safe to run again if needed

# Get the EC2 public IP from Terraform output
EC2_PUBLIC_IP=$(terraform output -raw ec2_public_ip)

# Check if Terraform output was successful
if [[ -z "$EC2_PUBLIC_IP" ]]; then
  echo "Error: Could not retrieve EC2 public IP. Make sure Terraform is applied."
  exit 1
fi

echo "EC2 Public IP: $EC2_PUBLIC_IP"

cd ..
# Define inventory file location

INVENTORY_FILE="./ansible/inventory.ini"
# Ensure SSH private key file path is correct
SSH_PRIVATE_KEY_PATH="${SSH_PRIVATE_KEY_PATH:-~/.ssh/4ansible.pem}"

echo "Contents of inventory.ini:"
cat $INVENTORY_FILE

sed -i "s|<EC2_PUBLIC_IP>|$EC2_PUBLIC_IP|g" $INVENTORY_FILE

echo "Updated $INVENTORY_FILE with EC2 Public IP: $EC2_PUBLIC_IP"

# Display the updated contents of inventory.ini for debugging
cat $INVENTORY_FILE
