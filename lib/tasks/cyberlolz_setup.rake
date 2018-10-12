namespace :cyberlolz_setup do
  desc "Create Post index if not exist"
  task _index: :environment do
    begin
      unless Post.__elasticsearch__.index_exists?
        puts "\033[33m[+]\033[0m Post index is not yet exist, creating index..."
        Post.__elasticsearch__.create_index!
        puts "\033[34m[+]\033[0m Post index created!"
      end
    rescue Faraday::ConnectionFailed
      puts "\033[31m[+]\033[0m Elasticsearch is not yet started!"
      sleep(5)
      retry
    end
  end

  desc "Create/Update pattern if not exist"
  task _pattern: :environment do
    title = "posts"

    while !KibanaDashboardApi.available? # wait 5sec if kibana is unvailable
      sleep(5)
    end

    pattern = KibanaDashboardApi::Index::Pattern.find_by_title(title)

    if !pattern
      puts "\033[33m[+]\033[0m Pattern `#{title}` is not yet exist, creating pattern..."
      pattern = KibanaDashboardApi::Index::Pattern.new(title: title, time_field_name: "updated_at", default_index: true)
      pattern.save
      puts "\033[34m[+]\033[0m Pattern `#{title}` created!"

      data = { :fieldFormatMap => {
                :url => { :id => "url",
                          :params => {
                            :labelTemplate => "View"
                          }
                },
                :id => { :id => "url",
                         :params => { :urlTemplate => "http://localhost:3001/#{title}/{{value}}",
                                      :labelTemplate => "\#{{value}}" }
                }
            }
      }
      
      pattern.update_attributes(data)
      puts "\033[34m[+]\033[0m Pattern `#{title}` updated!"
    else
      puts "\033[34m[+]\033[0m Pattern `#{title}` is already exist and configured"
    end
  end

  desc "Set Advanced Setting Kibana UserValue"
  task _advanced_setting: :environment do
    KibanaDashboardApi::Settings.set_date_format("Y/DD/MM - HH:mm:ss.SSS")
    puts "\033[34m[+]\033[0m DateFormat updated!"
  end

end
