#!/usr/bin/python
csv_file=open('/tmp/playbook_results/users_unix_check.csv','a')
csv_file.write('\n')
txt_file=open('/tmp/users_unix_check.txt', 'r')
content=txt_file.read()
txt_file.close()

for line in content.split(';'):
    try:
        user=line.split(':')[0].replace('\n','')
        groups=line.split(':')[1].replace('\n','')
        hostname=line.split(':')[2].replace('\n','')
        ip=line.split(':')[3].replace('\n','')

        for group in groups.split(' '):
            try:
                csv_file.write('"' + user + '","' + group + '","' + hostname + '","' + ip + '"\n')
            except:
                print("Error1")
    except:
        print("Error2")
csv_file.close()