## Moonshine Test App

* Fork the `moonshinetest` app into your Github account.

* Add `gem 'plugger'` to the `:development` group in the `Gemfile`.

* Download and setup moonshine:

```
$ mkdir -p vendor/plugins
$ cd vendor/plugins
$ git clone git://github.com/railsmachine/moonshine.git
$ rm -fr moonshine/.git/
$ rm moonshine/.gitignore
$ cd ../..
$ rails generate moonshine
```

* Edit `config/database.yml` with production settings. Hint: database host is `localhost` and add a randomly
generated password.

* Edit `config/deploy.rb` with the server’s hostname.

* Edit the `config/moonshine.yml` so that the `:repository:` setting is pointing to your fork of the `moonshinetest` repository.

* Add capistrano to the `:development` group in the `Gemfile`:

```
gem 'capistrano', '~> 2.15'
```

* Add the following to `config/application.rb` to prevent the moonshine manifests from being loaded by the app:

```
# don't attempt to auto-require the moonshine manifests into the rails env
# config.paths.app.manifests 'app/manifests', :eager_load => false
path_rejector = lambda { |s| s.include?("app/manifests") }
config.eager_load_paths = config.eager_load_paths.reject(&path_rejector)
# Remove the path from being lazily loaded
ActiveSupport::Dependencies.autoload_paths.reject!(&path_rejector)
```

* Commit and push all of your changes to your fork of the repository.

* Deploy setup and deploy the app to the server:

```
$ cap deploy:setup
$ cap deploy
```

* Ensure that there are no errors in the deploy and if there are fix them. Feel free to ask questions if you get stuck.

* Once the deploy is successful ensure that the app is loading at http://kpm.railsmachine.managedmachine.com

### Bonus: And the moonshine_iptables plugin

Follow the instructions in the README here: https://github.com/railsmachine/moonshine_iptables

NOTE: Moonshine has limited support for Rails 5 so to download the plugin use:

```
$ cd vendor/plugins
$ git clone git://github.com/railsmachine/moonshine_iptables.git
$ rm -fr moonshine_iptables/.git/
$ cd ../..
```

Then follow the remaining instructions from the README.
