### Deploy
website: deploy-wp


### Vault
vault-encrypt:
	ansible-vault encrypt vars/vault.yml

vault-decrypt:
	ansible-vault decrypt vars/vault.yml



### CMS
deploy-dp: website-http create-local-db dp-dl-ansible

deploy-wp: deploy-wp-base deploy-wp-full
deploy-wp-base: website-http create-local-db wp-dl-cli wp-config wp-permissions
deploy-wp-full: wp-core-cli wp-plugins-cli



### Testing
all: nginx-all db-all wp-all logging-all backups-all permissions-all test-files-all pingdom-all



### Nginx
nginx-all: nginx-logs nginx-http nginx-csr nginx-ssl nginx-https

nginx-logs:
	# Nginx logs
	ansible-playbook main.yml -i localhost -t logs



### HTTP
website-http: nginx-logs nginx-http

nginx-http:
	# Copy http serverblock
	ansible-playbook main.yml -i localhost -t http



### HTTPS
website-https: nginx-logs nginx-csr nginx-ssl nginx-https

nginx-csr:
	# Certificate signing request
	ansible-playbook main.yml -i localhost -t csr

nginx-ssl:
	# Copy ssl certificate
	ansible-playbook main.yml -i localhost -t ssl

nginx-https:
	# Copy https serverblock
	ansible-playbook main.yml -i localhost -t https



### AWS S3
website-s3:
	# Create aws bucket
	ansible-playbook main.yml -i localhost -t create_s3_bucket



### Database
db-all: dl-db-backup copy-local-db create-local-db restore-local-db remove-local-db create-rds-db remove-rds-db

dl-db-backup:
	# Download database backup
	ansible-playbook main.yml -i localhost -t dl_db_backup

copy-local-db:
	# Copy local database
	ansible-playbook main.yml -i localhost -t copy_local_db

create-local-db:
	# Create local database
	ansible-playbook main.yml -i localhost -t create_local_db

restore-local-db:
	# Restore local database
	ansible-playbook main.yml -i localhost -t restore_local_db

remove-local-db:
	# Remove local database
	ansible-playbook main.yml -i localhost -t remove_local_db

create-rds-db:
	# Create rds database
	ansible-playbook main.yml -i localhost -t create_rds_db

remove-rds-db:
	# Remove rds database
	ansible-playbook main.yml -i localhost -t remove_rds_db



### Wordpress
wp-all: wp-dl-ansible wp-dl-cli wp-config wp-permissions wp-core-cli wp-plugins-cli

wp-dl-ansible:
	# Download wordpress with ansible
	ansible-playbook main.yml -i localhost -t wp_dl_ansible

wp-dl-cli:
	# Download wordpress with wp-cli
	ansible-playbook main.yml -i localhost -t wp_dl_cli

wp-config:
	# Copy wp config
	ansible-playbook main.yml -i localhost -t wp_config

wp-permissions:
	# Set wp permissions
	ansible-playbook main.yml -i localhost -t wp_permissions

wp-core-cli:
	# Configure wp core cli
	ansible-playbook main.yml -i localhost -t wp_core_cli

wp-plugins-cli:
	# Install wordpress plugins with wp-cli
	ansible-playbook main.yml -i localhost -t wp_plugins_cli



### Drupal
dp-dl-ansible:
	# dp dl ansible
	ansible-playbook main.yml -i localhost -t dp_dl_ansible



### Logging
logging-all: logrotate

logrotate:
	# Install logrotate
	ansible-playbook main.yml -i localhost -t logrotate



### Backups
backups-all: backup-files dl-backup-files configure-duply configure-backup-cron backup-local-db backup-remote-db remove-old-backups

backup-files:
	# Backup files
	ansible-playbook main.yml -i localhost -t backup_files

dl-backup-files:
	# Download backup files
	ansible-playbook main.yml -i localhost -t dl_backup_files

configure-duply:
	# Configure duply
	ansible-playbook main.yml -i localhost -t configure_duply

configure-backup-cron:
	# Configure backup cron
	ansible-playbook main.yml -i localhost -t configure_backup_cron

backup-local-db:
	# Backup local database
	ansible-playbook main.yml -i localhost -t backup_local_database

backup-remote-db:
	# Backup remote database
	ansible-playbook main.yml -i localhost -t backup_remote_database

remove-old-backups:
	# Remove old backups
	ansible-playbook main.yml -i localhost -t remove_old_backups



### Permissions
permissions-all: website-temp-permissions website-revert-permissions

website-temp-permissions:
	# Temp wp permissions
	ansible-playbook main.yml -i localhost -t temp_permissions

website-revert-permissions:
	# Revert wp permissions
	ansible-playbook main.yml -i localhost -t revert_permissions



### Test files
test-files-all: php-test-file geoip-test-file

php-test-file:
	# Php test
	ansible-playbook main.yml -i localhost -t php_test

geoip-test-file:
	# Geoip test
	ansible-playbook main.yml -i localhost -t geoip_test



### Pingdom
pingdom-all: unpause-pingdom pause-pingdom

unpause-pingdom:
	# Unpause pingdom
	ansible-playbook main.yml -i localhost -t unpause_pingdom

pause-pingdom:
	# Unpause pingdom
	ansible-playbook main.yml -i localhost -t pause_pingdom
