# Dyno Metadata

Helpers to access [Heroku Dyno Metadata](https://devcenter.heroku.com/articles/dyno-metadata) from [`ENV`](https://ruby-doc.org/core-2.2.0/ENV.html). Graceful fallback to dummy values (useful in development).

Installation

    gem install dyno_metadata

Demonstration

```ruby
$ ruby -I lib -r dyno_metadata.rb -e '(DynoMetadata.methods - \
Object.methods).each { |method| puts \
"DynoMetadata.#{method}\n=> #{DynoMetadata.public_send(method)}" }'
DynoMetadata.app_id
=> 9daa2797-e49b-4624-932f-ec3f9688e3da
DynoMetadata.app_name
=> example-app
DynoMetadata.dyno_id
=> 1vac4117-c29f-4312-521e-ba4d8638c1ac
DynoMetadata.release_created_at
=> 2015-04-02T18:00:42Z
DynoMetadata.release_version
=> v42
DynoMetadata.slug_commit
=> 2c3a0b24069af49b3de35b8e8c26765c1dba9ff0
DynoMetadata.commit
=> 2c3a0b24069af49b3de35b8e8c26765c1dba9ff0
DynoMetadata.slug_description
=> Deploy 2c3a0b2
DynoMetadata.short_commit
=> 2c3a0b2
DynoMetadata.to_h
=> {:app_id=>"9daa2797-e49b-4624-932f-ec3f9688e3da", :app_name=>"example-app", :dyno_id=>"1vac4117-c29f-4312-521e-ba4d8638c1ac", :release_created_at=>"2015-04-02T18:00:42Z", :release_version=>"v42", :slug_commit=>"2c3a0b24069af49b3de35b8e8c26765c1dba9ff0", :slug_description=>"Deploy 2c3a0b2", :short_commit=>"2c3a0b2"}
```
