#!/usr/bin/python
import re

date_pattern = re.compile("^\w{3} \w{3}.*")
date_dict={"Seg": "Mon","Ter":"Tue", "Qua": "Wed","Qui": "Thu","Sex":"Fri","Sab":"Sat","Dom":"Sun","Fev":"Feb","Abr":"Apr","Mai":"May","Ago":"Aug","Set":"Sep","Out":"Oct","Dez":"Dec"}

csv_file=open('/tmp/playbook_results/users_unix_check.csv','a')
csv_file.write('\n')
txt_file=open('/tmp/users_unix_check.txt', 'r')
content=txt_file.read()
content=re.sub(r';$','', content)
txt_file.close()

for line in content.split(';'):
    try:
        user=line.split(',')[0].replace('\n','')
        groups=line.split(',')[1].replace('\n','')
        hostname=line.split(',')[2].replace('\n','')
        ip=line.split(',')[3].replace('\n','')
        last_login=line.split(',')[4].replace('\n','')

        if not date_pattern.search(last_login):
            last_login="Never"
        else:
            for key, value in date_dict.items():
                last_login=last_login.replace(key,value)

        for group in groups.split(' '):
            try:
                csv_file.write('"' + user + '","' + group + '","' + hostname + '","' + ip + '","' + last_login + '"\n')
            except:
                print("Error1 on group: " + group)
                #print("Results: user,group,hostname,ip,lastlogin: " + user +', '+ hostname+', '+ip+', '+last_login )
    except:
        print("Error2 in line:" + line)
csv_file.close()