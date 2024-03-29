### This repository provides Hashicorp Packer setup to build a Vagrant box with HashiCorp Vault installed, integrate it with Systemd,test it with Inspec and KitchenCI and finally to upload it to VagrantCloud.

#### How to use it :

- Execute `git clone git@github.com:martinhristov90/packerVault.git`.
- Export the env variable named `VAGRANT_CLOUD_TOKEN` with your VagrantCloud token in it. The token can be generated by visiting [this](https://app.vagrantup.com/settings/security) link.
- Substitute in the `template.json` fields where it says YOUR_VAGRANTCLOUD_NAME.
- Execute `packer build template.json` to start the building process.
- Test the box with KitchenCI if Vault is installed correctly, using the instructions below : 

#### How to setup KitchenCI (MacOS Mojave).
    
- For using [KitchenCI](https://kitchen.ci/), ruby environment needs to be set up first.
- Run `brew install ruby`
- After previous command finish, run `gem install rbenv`, this would give you ability to choose particular version of Ruby. This is a prerequisite.
- Next, [Bundler](https://bundler.io) needs to be installed, run `gem install bundler`, this would provide the dependencies that KitchenCI needs. It is going to install the Gems defined in the   `Gemfile`
- Run the following two commands, to setup Ruby environment for the local directory.
    ```bash
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    ```
- Reload your BASH interpreter or apply the changes to the profile :
    ```shell
    source ~/.bash_profile 
    ```
- Verify rbenv is installed properly with :
    ```shell
    type rbenv   # → "rbenv is a function"
    ```
- To install the particular version that we need, run the following command in the project directory:
    ```shell
    rbenv install 2.5.3
    ```
- Set local version to be used with command :
    ```shell
    rbenv local 2.5.3
    ```
- Previous step is going to create a file named .ruby-version, with the following content `2.5.3`
- Install the needed Gems for KitchenCI using Bundle with command :
    ```shell
    bundle install
    ```
- Run Kitchen in the context of Bundle with the following command : 
    ```shell
    bundle exec kitchen list
    ```
- Build the testing environment with:
    ```shell
    bundle exec kitchen converge
    ```
- Test it : 
    ```shell
    bundle exec kitchen verify
    ```
- If Consul is installed, you should get an output like this :
    ```shell
    Profile: Checking Vault installation (vault_installation)
    Version: 1.0.0
    Target:  ssh://vagrant@127.0.0.1:2204

      ✔  vault_install: vault_install
         ✔  Service vault should be enabled
         ✔  Service vault should be running
    Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
    Test Summary: 2 successful, 0 failures, 0 skipped
    ```
- To destroy the testing environment use :
    ```shell
    bundle exec kitchen destroy
    ```
- (optional) To upload the box to Vagrant Cloud use :
    ```
    vagrant cloud publish (options)
    ```


#### N.B : 
- Before starting the build process create an empty box in VagrantCloud with name `vault`, for example `YOUR_VAGRANTCLOUD_NAME/vault`, this is a workaround, otherwise you are going to get an error in uploading the box to VagrantCloud.
- The machine automatically exposes tcp/udp ports 8200 and 8201 to your host machine.
- Inspec profile can be found in [this](https://github.com/martinhristov90/inspecVault) repository.