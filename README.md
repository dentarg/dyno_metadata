# Dyno Metadata

[![Travis Build Status](https://travis-ci.org/dentarg/dyno_metadata.svg?branch=master)](https://travis-ci.org/dentarg/dyno_metadata)
[![GitHub Build Status](https://github.com/dentarg/dyno_metadata/workflows/Ruby/badge.svg)](https://github.com/dentarg/dyno_metadata/actions)

Helpers to access [Heroku Dyno Metadata](https://devcenter.heroku.com/articles/dyno-metadata) from [`ENV`](https://ruby-doc.org/core-2.2.0/ENV.html). Graceful fallback to dummy values (useful in development).

Installation

    gem install dyno_metadata

Methods

```ruby
$ ruby -I lib -r dyno_metadata.rb -e ' \
(DynoMetadata.methods - Object.methods).each { |method| \
  puts "DynoMetadata.#{method}\n" ; \
}'
DynoMetadata.app_id
DynoMetadata.app_name
DynoMetadata.dyno_id
DynoMetadata.release_created_at
DynoMetadata.release_version
DynoMetadata.slug_commit
DynoMetadata.commit
DynoMetadata.slug_description
DynoMetadata.short_commit
DynoMetadata.to_h
```

Demonstration

```ruby
$ ruby -I lib -r dyno_metadata.rb -e ' \
(DynoMetadata.methods - Object.methods).each { |method| \
  puts "> DynoMetadata.#{method}\n" ; \
  print "=> " ; \
  p DynoMetadata.public_send(method) \
} ; \
puts "> DynoMetadata.short_commit(12)\n" ; \
print "=> " ; \
p DynoMetadata.short_commit(12)'
> DynoMetadata.app_id
=> "9daa2797-e49b-4624-932f-ec3f9688e3da"
> DynoMetadata.app_name
=> "example-app"
> DynoMetadata.dyno
=> "web.1"
> DynoMetadata.dyno_id
=> "1vac4117-c29f-4312-521e-ba4d8638c1ac"
> DynoMetadata.release_created_at
=> "2015-04-02T18:00:42Z"
> DynoMetadata.release_version
=> "v42"
> DynoMetadata.slug_commit
=> "2c3a0b24069af49b3de35b8e8c26765c1dba9ff0"
> DynoMetadata.commit
=> "2c3a0b24069af49b3de35b8e8c26765c1dba9ff0"
> DynoMetadata.slug_description
=> "Deploy 2c3a0b2"
> DynoMetadata.short_commit
=> "2c3a0b2"
> DynoMetadata.to_h
=> {:app_id=>"9daa2797-e49b-4624-932f-ec3f9688e3da", :app_name=>"example-app", :dyno=>"web.1", :dyno_id=>"1vac4117-c29f-4312-521e-ba4d8638c1ac", :release_created_at=>"2015-04-02T18:00:42Z", :release_version=>"v42", :slug_commit=>"2c3a0b24069af49b3de35b8e8c26765c1dba9ff0", :slug_description=>"Deploy 2c3a0b2", :short_commit=>"2c3a0b2"}
> DynoMetadata.short_commit(12)
=> "2c3a0b24069a"
```

## Development

### Release workflow

* Update the demonstration in this README if needed.

* Bump the version in `version.rb` in a commit, no need to push (the release task does that).

* Build and [publish](http://guides.rubygems.org/publishing/) the gem. This will create the proper tag in git, push the commit and tag and upload to RubyGems. Use [keycutter](https://github.com/joshfrench/keycutter) to manage multiple RubyGems accounts.

        bundle exec rake release

    * If you are not logged in as on the correct account, the rake task will fail and tell you to set credentials via `gem push`, do that and run the `release` task again. Use [keycutter](https://github.com/joshfrench/keycutter) to manage multiple RubyGems accounts.

* Update the changelog with [GitHub Changelog Generator](https://github.com/skywinder/github-changelog-generator/) commit and push manually.

        github_changelog_generator
