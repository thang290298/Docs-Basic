#!/bin/bash
# Openlitespeed reset password
# ThangNV NhanHoa Cloud Team
# Get info mysql_root_passwd
old_passwd_mysl=0435626533aA
# Input from cloud-init
new_passwd_1=$1
new_passwd_2=$2
# Input from random
# new_passwd_1=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
# Change password
mysqladmin --user=root --password=$old_passwd_mysl password $new_passwd_1
echo -e "admin\n$new_passwd_2\n$new_passwd_2" | /usr/local/lsws/admin/misc/admpass.sh
# Restart Openlitespeed
systemctl restart lsws
systemctl restart mysqld
# DONE

mã hóa

```
H4sIAFEhMmEAA21RTUsDMRS87694tisossZu273IHqSKemmhFE9CSTevbiAfa16WUvDHmwSrbfGUSebN5A0zvGAbadiGU5sNYdGhUdIjdYgCHBJ66DjRzjoR6FXLzcf8DebhfLEcZsr2AlbIdSCfw6w0Wwt6T59q7az166QVmVXiB64Dqeq7yXhaldV0POYPQflqut7D1lkNTXQspJE+M7g7iEZ1Pjq+l3VenuocN8LGLU5VV4J7hJtLgi+glpfTinodcIiL1SSAFrmAooFRBfeATWuvg8csxsS/4CkQF1oaKIqe0NUxXMCHiTo/S/irhfx4oSz+AAXCILm9m2O2PLsOwnqsJ8eUbbhiinbEkoxpSU2EcfI29bZE8tz50/4y2pNH3XgVm0x8NPnnOQWMBT8u5k/ZNxXxgTUTAgAA
```