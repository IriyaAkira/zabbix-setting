# zabbix-setting
## Getting Start
Clone this repository to your home directory or a similar location.
```bash
git clone https://github.com/IriyaAkira/zabbix-setting.git
```
Execute the following command.   
The official Zabbix GitHub repository will be cloned into the home directory.  
To build a Zabbix server using Docker, utilize the official Zabbix GitHub repository with minimal modifications. This repository automates installation, backups, and other tasks while also running a reverse proxy.
```bash
bash ./zabbix-setting/server/install.sh
```

## Lisence
This repository does not contain any application code or Docker images.

It only provides scripts to pull and run the official zabbix Docker image:
- https://github.com/zabbix/zabbix-docker

Please refer to the original project and Docker image page for license information.