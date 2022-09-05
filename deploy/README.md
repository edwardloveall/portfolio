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
