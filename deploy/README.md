# Deployment

Deployment for this app works via [Ansible].

## Staging

You can test in a staging environment using [Vagrant].

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

[Ansible]: https://www.ansible.com/
[Vagrant]: https://www.vagrantup.com/
