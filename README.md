* systemctl status snmpd.service
* ll /etc/snmp/snmptrapd.conf
* ll /etc/snmp/snmpd.conf
* ll /usr/bin/zabbix_trap_receiver.pl
* ll  /usr/share/snmp/snmp_perl_trapd.pl
* chcon -v --type=snmpd_exec_t /usr/share/snmp/snmp_perl_trapd.pl
* restorecon -v /usr/share/snmp/snmp_perl_trapd.pl
* chcon -v --type=snmpd_exec_t  /usr/bin/zabbix_trap_receiver.pl
* restorecon -v /usr/binzabbix_trap_receiver.pl
* yum install net-snmp-perl
* yum install perl-CPAN
* install net-snmp-libs (inslall mibs)
* systemctl status snmptrapd
* lsof -i :162
* ls -Z /usr/share/snmp/mibs/NET-SNMP-VACM-MIB.txt
* sudo chcon system_u:object_r:snmpd_exec_t:s0 /usr/share/snmp/mibs/NET-SNMP-VACM-MIB.txt
* snmpwalk -v3 -u zabbix -l authPriv -a SHA -A z@bbixbakh -x AES -X z@bbixbakh 172.20.0.3
* docker run -d --name ubuntu1 --net zabbix-net --ip 172.20.240.8 --restart unless-stopped ubuntu sleep infinity
