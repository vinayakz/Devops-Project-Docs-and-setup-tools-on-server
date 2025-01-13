#!/bin/bash 

  

# Input parameters 

source_dir=$1 

target_dir=$2 

  

timestamp=$(date '+%Y-%m-%d-%H-%M-%S') 

  

backup_dir="${target_dir}/backup_${timestamp}" 

  

function create { 

    zip -r "${backup_dir}.zip" "${source_dir}" 

  

    if [ $? -eq 0 ]; then 

        echo "Backup created successfully." 

    else 

        echo "Backup was not performed for $timestamp." 

    fi 

} 

  

function perform_rotation { 

    # Get a list of backups in descending order of modification time 

    backups=($(ls -t "$target_dir"/backup_*.zip 2>/dev/null)) 

  

    if [ ${#backups[@]} -eq 0 ]; then 

        echo "No backups found in target directory: $target_dir" 

        return 

    fi 

  

    echo "Existing backups:" 

    printf "%s\n" "${backups[@]}" 

  

    # Retain the latest 5 backups 

    if [ "${#backups[@]}" -gt 5 ]; then 

        backups_to_remove=("${backups[@]:5}") 

  

        echo "Removing old backups:" 

        for backup in "${backups_to_remove[@]}"; do 

            echo "Deleting $backup" 

            rm -f "$backup" 

        done 

    else 

        echo "No backups need to be removed. Total backups: ${#backups[@]}" 

    fi 

} 

  

# Call the functions 

perform_rotation 
