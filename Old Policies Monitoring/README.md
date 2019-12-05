# Old Policies Monitoring

## Intro

Monitors Fortinet's Fortigate firewalls for policies which the last hit is older than N days, being N any integer desired, then outputing the result into a HTTP Push Data Advanced in PRTG. The final result is like below:

![Old Policies Sensor](/assets/images/old_policy_sensor.png)

## Setup

The setup is fairly easy, being one able to use after editing the following lines in [old_policy_main.yml](old_policy_main.yml):

line 4 and 13: the `time_to_be_old` is used to define the number of days the script will compare to the last access to define what is old and what is not. The line 13 is purely visual, being the number that appears in the PRTG Message as show before.
line 12: the `url` variable is the url in which PRTG is accessible. The script is made with security in mind, so the default is using TLS v1.2 in port 5051 (PRTG's default), but these settings can also be changed.

When creating the HTTP Push Data Advanced in PRTG, the token used will be the hostname of the firewall + `_old_policy_test`. This can be manually changed in code, but is not recommended.

The recommended testing cycle is to used a schedule to run the playbook once a day or once a week.
