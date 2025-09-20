## Ansible guide companion repo

Companion repo for my ansible guide: https://gyaaniguy.top/blog/ansible-basics/  

Please read the above guide to learn more about ansible, what it can do, how to install and use it.  


## How to execute scripts found in this repo:

Ansible is the most fantastic depoyment and server management tool known to man ! Its time it gets some more recognition. 

First make sure ansible is installed. 

I wouldn't advise running these scripts blindly. In many cases you would need to adapt the playbooks (yml scripts) for your own purposes. 

#### Install apps below command runs the apt.yml task

ansible-playbook ./playbooks/apps.yml --user root -i ./inventory/hosts -l servername

#### Create user
➜ansible-playbook ./playbooks/user.yml --user root -i ./inventory/hosts -l servername --extra-vars="u=test p=longpassword"

#### zsh
 ansible-playbook -vv ./playbooks/zsh.yml  -i ./inventory/hosts -l servername -e user=remoteuser

#### Caddy
ansible-playbook ./playbooks/caddy.yml --user root -i ./inventory/hosts -l servername

#### Php
ansible-playbook ./playbooks/php.yml --user root -i ./inventory/hosts -l servername

#### fnm, node, npm
# Note the user is the user that needs node installed.
 ansible-playbook ./playbooks/fnm.yml --user remoteuser -i ./inventory/hosts -l servername

#### Running on localhost
 ansible-playbook ./playbooks/php.yml --user root -i ./inventory/hosts -l local --ask-become-pass


#### Laravel

This requires 3 steps. a) setup a git bare repo on server b) setup git locally to push to the bare repo c) push code and deploy using ansible

`bare_repo=/home/remoteuser/barerepoDir.git` - path to bare repo on server
`app_path=/var/www/barerepoDir` - Path where laravel application will be deployed to

1. This playbook will setup a bare git repository on the server
```bash
ansible-playbook ~/work/ansibleDir/playbooks/laravel_setup.yml \    
--user root \
-i ~/work/ansibleDir/inventory/hosts -l buyvm \
--extra-vars "bare_repo=/home/remoteuser/barerepoDir.git" \
--ask-become-pass
```

2. Next cd into your laravel app and setup git so we can push to the bare repo created on the server

```bash
git init ; git add . ; git commit -m 'init' ; git remote add origin ssh://remoteuser@somesite.com/home/remoteuser/barerepoDir.git ; git push --set-upstream origin main
```

3. Finally run the second playbook to actually push and deploy the website run the below playbook. Run this whenever you need update prod

```bash
git push && \
ansible-playbook ~/work/ansibleDir/playbooks/laravel.sqlite.yml \
--user root \
-i ~/work/ansibleDir/inventory/hosts -l buyvm \
--extra-vars "app_path=/var/www/barerepoDir bare_repo=/home/remoteuser/barerepoDir.git" \
--ask-become-pass
```

4. Of course update your web server accordingly