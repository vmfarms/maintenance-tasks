#!/bin/bash

# Function to convert date to seconds since the epoch
date_to_seconds() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux (GNU date)
        date -d "$1" +%s
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OS X (BSD date)
        date -j -f "%Y-%m-%dT%H:%M:%S.000Z" "$1" +%s
    fi
}

# Get the list of instance IDs and their corresponding AMI IDs
instances=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, ImageId]' --output text)

# Current date for age comparison
current_date=$(date +%s)

echo "Instance ID | AMI ID | AMI Age (Days)"

# Loop through the instances
while read -r instance_id ami_id; do
    # Get AMI creation date
    creation_date=$(aws ec2 describe-images --image-ids "$ami_id" --query 'Images[*].CreationDate' --output text)
    creation_date_ts=$(date_to_seconds "$creation_date")

    # Calculate the age of the AMI
    age=$(( (current_date - creation_date_ts) / 86400 ))

    # Output the instance ID, AMI ID, and AMI age
    echo "$instance_id | $ami_id | $age days"
done <<< "$instances"
