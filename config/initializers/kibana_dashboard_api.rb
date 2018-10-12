KibanaDashboardApi.configure do |conf|
  conf.base_uri.host = ENV["KIBANA_HOST"]
  conf.base_uri.port = ENV["KIBANA_PORT"]
  conf.base_headers[:content_type] = "application/json; charset=UTF-9"
  conf.base_headers[:kbn_xsrf] = "http://#{ENV['KIBANA_HOST']}:#{ENV['KIBANA_PORT']}/"
end