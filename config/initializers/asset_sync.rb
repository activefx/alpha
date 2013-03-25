# Be sure to run heroku labs:enable user-env-compile -a myapp
# to allow for ENV usage variable during rake assets:precompile
# def asset_sync_available?
#   defined?(AssetSync)
# end

# def asset_sync_keys_defined?
#   !configatron.aws.access_key_id.nil? &&
#   !configatron.aws.secret_access_key.nil? &&
#   !configatron.aws.asset_bucket?
# end

# def use_asset_sync?
#   asset_sync_available? && asset_sync_keys_defined?
# end

if defined?(AssetSync)

  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.aws_access_key_id = configatron.aws.access_key_id
    config.aws_secret_access_key = configatron.aws.secret_access_key
    config.fog_directory = configatron.aws.asset_bucket

    # Increase upload performance by configuring your region
    config.fog_region = 'us-east-1'

    # Don't delete files from the store
    config.existing_remote_files = "delete"

    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true

    # Use the Rails generated 'manifest.yml' file to produce the list of files to
    # upload instead of searching the assets directory.
    config.manifest = true

    # Fail silently.  Useful for environments such as Heroku
    config.fail_silently = true
  end

end
