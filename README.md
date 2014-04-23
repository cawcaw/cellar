CELLΛR
=
Multisite mustache hosting.
Currently deep beta and actively developed.

First steps.
-

Install the gem:

``` shell
gem install cellar
```

And make Cellar application:

``` shell
cellar new cellapp
````

These two simple steps will create a platform for hosting many sites at once.

For reference, see in cellapp/sites/example

Confyg and start.
-

Now you need to check config/database.yml and enable your favorites gems in Gemfule:

``` ruby
# # please, uncoment gems that you want to use
# gem 'coffee-script'
# gem 'sass'
# gem 'less'
# gem 'therubyracer' # dependent for Less
```

After this install bundle and create database:

``` shell
cd cellapp
bundle
rake db:reset
```
