Role Name
=========

Website role

Requirements
------------

Ansible
Ubuntu or Debian server

Role Variables
--------------

Located in vars directory

Create vars/dev-secrets.yml

---
# Admin email
admin_email:

### AWS
aws_region:

### Mysql
# MySQL user
db_user:
db_user_password:

# MySQL root user
mysql_root_user:
mysql_root_password:

### WP installation
wp_user:
wp_user_password:


And vault.yml

---
# Admin email
vault_admin_email:

### AWS
vault_aws_region:

### Mysql
# MySQL user
vault_db_user:
vault_db_user_password:

# MySQL root user
vault_mysql_root_user:
vault_mysql_root_password:

### WP installation
vault_wp_user:
vault_wp_user_password:


Dependencies
------------

None

Example Playbook
----------------

Located in git repository

License
-------

BSD
