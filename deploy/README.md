# Deployment

Deployment for this app uses [Ansible].

## Testing locally

You can test in a local environment using [Vagrant].

```sh
vagrant up # if this stalls out, see below
ansible-playbook -i inventories/staging.yml setup.yml
```

For some reason that I can't figure out, when `vagrant up` is run, it stalls out printing `Authentication failure. Retrying...`. If you add this to the Vagrantfile:

```ruby
config.vm.provider :virtualbox do |vb|
  vb.gui = true
end
```

you can see that it's at least stuck on the login screen which might have something to do with it. However, if you cancel out with `^C` and run `vagrant ssh` it works fine so...

## Actually deploying

From the root of the project (not this directory, but one above) you can run

```sh
bin/deploy
```

[Ansible]: https://www.ansible.com/
[Vagrant]: https://www.vagrantup.com/

## Getting content from an old server

First you'll want to make a db backup on the server:

```sh
pg_dump -U <role> -a portfolio_production | gzip > production-$(date +%F).bak.gz
```

Logout of the server and download the backup:

Connect to the new server to grab the database backup. Make sure you forward the SSH agent so you can connect to the old server from the new server using your local computer's SSH credentials:

```sh
ssh -p 0000 -o ForwardAgent=yes user@server
```

Download, extract, and load the database backup:

```sh
sftp -P 0000 user@old-server:production-YYYY-MM-DD.bak.gz production-YYYY-MM-DD.bak.gz
gunzip -c production-YYYY-MM-DD.bak.gz | psql portfolio_production
```

Finally, grab all the stored files (for projects, songs, etc):

```sh
sftp -r -P 0000 user@server:/path/to/portfolio/storage ~/portfolio/storage
```

## Getting LetsEncrypt certs from an old server

Read this:

<https://ivanderevianko.com/2019/03/migrate-letsencrypt-certificates-certbot-to-new-server>

But also:

### On old server

Compress the certs and configs

```sh
sudo tar -chvzf certs.tar.gz /etc/letsencrypt/archive /etc/letsencrypt/renewal
```

### On new server

Transfer the certs from the old machine

```sh
sftp -P 0000 old@ip.ad.dr.ess:certs.tar.gz certs.tar.gz
```

Un-tar them. If you do it from the root, they'll go to the correct place.

```sh
cd /
sudo tar -xvf ~/certs.tar.gz
```

Make directories for the live domains

```sh
sudo mkdir -p /etc/letsencrypt/live/edwardloveall.com
sudo mkdir -p /etc/letsencrypt/live/blog.edwardloveall.com
```

Check what the more recent cert is for each domain:

```sh
ls /etc/letsencrypt/archive/edwardloveall.com
# shows something like cert18.pem
```

Link certs (note the `18` at the end of each of these):

```sh
sudo ln -s /etc/letsencrypt/archive/edwardloveall.com/cert18.pem /etc/letsencrypt/live/edwardloveall.com/cert.pem
sudo ln -s /etc/letsencrypt/archive/edwardloveall.com/chain18.pem /etc/letsencrypt/live/edwardloveall.com/chain.pem
sudo ln -s /etc/letsencrypt/archive/edwardloveall.com/fullchain18.pem /etc/letsencrypt/live/edwardloveall.com/fullchain.pem
sudo ln -s /etc/letsencrypt/archive/edwardloveall.com/privkey18.pem /etc/letsencrypt/live/edwardloveall.com/privkey.pem
```

So the same for the blog (possibly with a different number):

```sh
sudo ln -s /etc/letsencrypt/archive/blog.edwardloveall.com/cert18.pem /etc/letsencrypt/live/blog.edwardloveall.com/cert.pem
sudo ln -s /etc/letsencrypt/archive/blog.edwardloveall.com/chain18.pem /etc/letsencrypt/live/blog.edwardloveall.com/chain.pem
sudo ln -s /etc/letsencrypt/archive/blog.edwardloveall.com/fullchain18.pem /etc/letsencrypt/live/blog.edwardloveall.com/fullchain.pem
sudo ln -s /etc/letsencrypt/archive/blog.edwardloveall.com/privkey18.pem /etc/letsencrypt/live/blog.edwardloveall.com/privkey.pem
```
