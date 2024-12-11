These scripts will allow you to go from a working Django repository to a fully deployed website (even on the internet) in four easy steps.
It will install and configure a full stack including Postgres, Nginx, Gunicorn, and Certbot SSL.

# Requirements
- A working Django app in a git repository
- A Ubuntu 24.04 server on which to deploy your website, preferably a clean install.
      This can be an account on a VPS, a physical machine, a MultiPass instance, whatever.   

# Instructions


- On your server, in some convenient location, do
```
git clone https://github.com/jasonful/DjangoDeploy.git
```

- Edit the three .env files to fill in your own info, and set your own passwords.  The files are self-documenting.
- Run
```
    sudo bash setup.sh
```
- Assuming setup.sh succeeds, then your server is all set up, and you will be logged in as $DJANGO_USER.  
- At this point, because the env files contain secrets, you should delete your clone of DjangoDeploy. Everything you still need will have been placed in your django directory under /env and you should treat that directory as secret, i.e., do not add it to your repo.
- To start serving the website:
<pre>
    bash ~/django/<i>myapp</i>/env/startservers.sh
</pre>
