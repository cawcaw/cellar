DB_CONFIG = YAML.load_file(File.join(APP_PATH, 'config/database.yml'))

Dir.glob(File.expand_path('../tasks/*.rake', __FILE__), &method(:load))

