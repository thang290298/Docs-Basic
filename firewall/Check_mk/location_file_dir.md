# Các thư mục liên quan trong giám sát 

## Linux

`/usr/bin/check_mk_agent`:	Vị trí cài đặt checkmk

`/usr/lib/check_mk_agent`:	Thư mục home của agent extensions

`/usr/lib/check_mk_agent/plugins`:	Nơi đặt các plugins

`/usr/lib/check_mk_agent/local`:	Nơi đặt ‘local checks’ của user

`/var/lib/check_mk_agent`:	Nơi chứa dữ liệu của checkmk agent

`/var/lib/check_mk_agent/cache`:	Nơi chứa dữ liệu cache của các phiên.

`/var/lib/check_mk_agent/job`:	Nơi chứa dữ liệu job. Các file này sẽ được add vào output mỗi khi agent thực thi

`/var/lib/check_mk_agent/spool`:	Contains data created by e.g., cron jobs, and that includes its own section. These are also appended to the agent output.

`/etc/check_mk`:	Nơi chứa các file cấu hình của agents

`/etc/check_mk/mrpe.cfg`:	File cấu hình cho MRPE – for the execution of standard, Nagios-compatible check plug-ins.

`/etc/check_mk/encryption.cfg`:	Cấu hình cho mã hóa của dữ liệu agent

`/etc/xinetd.d/check_mk_agent`:	Cấu hình cho xinetd, thứ kết nối các output của agent tới TCP-Port 6556.

`local/share/check_mk/agents/custom`:	The home directory for own files which are to be delivered with baked agents.

## Windows

Trên host được giám sát

`C:\Program Files (x86)\checkmk\service\`	Installation directory for the program-specific files. The actual agent check_mk_agent.exe is also stored here.

`C:\ProgramData\checkmk\agent\`	Installation directory for the host-specific files. Here are extensions, logs and configuration files specific to this host.

`C:\ProgrammData\checkmk\agent\check_mk.user.yml`	Configuration changes made by the user are stored here.

`C:\ProgrammData\checkmk\agent\bakery\check_mk.bakery.yml`	Configuration alterations from the bakery are stored here.

`C:\ProgrammData\checkmk\agent\plugins`	Here plug-ins which are to be executed automatically by the agent are stored.

`C:\ProgrammData\checkmk\agent\local`	The directory for your own local-scripts

`C:\ProgrammData\checkmk\agent\mrpe`	MRPE extensions can be saved here.

`C:\ProgrammData\checkmk\agent\backup`	The user configuration creates a backup here after each change to the Checkmk agent service.

Trên checkmk server 

`local/share/check_mk/agents/custom/`	Base directory for own files that should be delivered with a baked agent.

`share/check_mk/agents/windows/`	The agents and their MSI packages are stored here. In this directory you will also find configuration examples and all plug-ins for the agent.