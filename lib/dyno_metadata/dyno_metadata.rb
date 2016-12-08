# frozen_string_literal: true

module DynoMetadata
  module_function

  def app_id
    fetch "HEROKU_APP_ID", "9daa2797-e49b-4624-932f-ec3f9688e3da"
  end

  def app_name
    fetch "HEROKU_APP_NAME", "example-app"
  end

  def dyno_id
    fetch "HEROKU_DYNO_ID", "1vac4117-c29f-4312-521e-ba4d8638c1ac"
  end

  def release_created_at
    fetch "HEROKU_RELEASE_CREATED_AT", "2015-04-02T18:00:42Z"
  end

  def release_version
    fetch "HEROKU_RELEASE_VERSION", "v42"
  end

  def slug_commit
    fetch "HEROKU_SLUG_COMMIT", "2c3a0b24069af49b3de35b8e8c26765c1dba9ff0"
  end
  singleton_class.send(:alias_method, :commit, :slug_commit)

  def slug_description
    fetch "HEROKU_SLUG_DESCRIPTION", "Deploy 2c3a0b2"
  end

  def short_commit
    slug_commit[0, 7]
  end

  def to_h
    {
      app_id:             app_id,
      app_name:           app_name,
      dyno_id:            dyno_id,
      release_created_at: release_created_at,
      release_version:    release_version,
      slug_commit:        slug_commit,
      slug_description:   slug_description,
      short_commit:       short_commit,
    }
  end

  private_class_method def fetch(variable_name, fallback)
    ENV.fetch(variable_name) { fallback }
  end
end
