# frozen_string_literal: true

module DynoMetadata
  module_function

  def app_id
    fetch "HEROKU_APP_ID", "9daa2797-e49b-4624-932f-ec3f9688e3da"
  end

  def app_name
    fetch "HEROKU_APP_NAME", "FLY_APP_NAME", "example-app"
  end

  def dyno
    fetch "DYNO", "web.1"
  end

  def dyno_id
    fetch "HEROKU_DYNO_ID", "FLY_ALLOC_ID", "1vac4117-c29f-4312-521e-ba4d8638c1ac"
  end

  def fly_alloc_id
    fetch "FLY_ALLOC_ID", "b996131a-5bae-215b-d0f1-2d75d1a8812b"
  end

  def fly_region
    fetch "FLY_REGION", "ams"
  end

  def fly_public_ip
    fetch "FLY_PUBLIC_IP", "127.0.0.1"
  end

  def fly_vcpu_count
    fetch "FLY_VCPU_COUNT", "99"
  end

  def fly_vm_memory_mb
    fetch "FLY_VM_MEMORY_MB", "1337"
  end

  def release_created_at
    fetch "HEROKU_RELEASE_CREATED_AT", "RELEASE_CREATED_AT", "2015-04-02T18:00:42Z"
  end

  def release_version
    fetch "HEROKU_RELEASE_VERSION", "RELEASE_VERSION", "v42"
  end

  def slug_commit
    fetch "HEROKU_SLUG_COMMIT", "RELEASE_COMMIT", "2c3a0b24069af49b3de35b8e8c26765c1dba9ff0"
  end
  singleton_class.send(:alias_method, :commit, :slug_commit)
  singleton_class.send(:alias_method, :release_commit, :slug_commit)

  def slug_description
    fetch "HEROKU_SLUG_DESCRIPTION", "Deploy 2c3a0b2"
  end

  def short_commit(length = 7)
    slug_commit[0, length]
  end

  def to_h # rubocop:disable Metrics/MethodLength
    {
      app_id:             app_id,
      app_name:           app_name,
      dyno:               dyno,
      dyno_id:            dyno_id,
      release_created_at: release_created_at,
      release_version:    release_version,
      slug_commit:        slug_commit,
      slug_description:   slug_description,
      short_commit:       short_commit,
    }
  end

  private_class_method def fetch(*variable_names, fallback)
    variable_names.each do |var_name|
      return ENV[var_name] if ENV.key?(var_name)
    end

    fallback
  end
end
