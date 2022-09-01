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
