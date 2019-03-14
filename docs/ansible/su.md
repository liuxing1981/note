# in command line
```
-b, --become run operations with become (does not imply password prompting)
--become-method=BECOME_METHOD
                        privilege escalation method to use (default=sudo),
                        valid choices: [ sudo | su | pbrun | pfexec | doas |
                        dzdo | ksu | runas | pmrun | enable ]
 --become-user=BECOME_USER run operations as this user (default=root)
ansible all -i inventory -b --become-method=su --become-user=root -m script -a "scripts/su.sh RoamAreaList.jsp"
```

# in playbook
```
- hosts: pgw
  tasks:
    - name: test
      become: yes
      become_user: root
      become_method: su
      script: scripts/su.sh RoamAreaList.jsp
      register: a
    - debug: var=a
```