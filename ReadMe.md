These scripts will allow you to go from a working Django repository to a fully deployed website (even on the internet) in four easy steps.
It will install and configure a full stack including Postgres, Nginx, Gunicorn, and Certbot SSL.

# Requirements
- A working Django app in a git repository
- A Ubuntu 24.04 server on which to deploy your website, preferably a clean install.
      This can be an account on a VPS, a physical machine, a MultiPass instance, whatever.   

# Instructions

- Edit the three .env files to fill in your own info, and set your own passwords.  The files are self-documenting.
- Make all the files from this repository (namely, example.com, local.env, production.env, setup.env, setup.sh, startservers.sh, unsetup.sh) available to your server.  Doesn't really matter how: If it's a physical machine, you can plug in a USB stick.  If it's a MultiPass instance, you can mount it.  If it's a VPS, you can rsync or scp the files.  Because the env files contain secrets, you should delete/unmount them when all done.  Versions you need will be placed in your django directory under /env and you should treat that directory as secret.
- Run
```
    sudo bash setup.sh
```
- If setup.sh succeeds, then your server is all set up, and you will be logged in as $DJANGO_USER.  To start serving the website:
```
    bash startservers.sh
```
