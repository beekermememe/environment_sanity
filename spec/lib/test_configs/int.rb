# Settings specified here will take precedence over those in config/environment.rb


# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes                                 = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true


#new memcache namespace between server restarts
libmemcached_options = {
  :prefix_key        => ENV['RAILS_CACHE_PREFIX'],
  :compression       => false,
  :debug             => false,
  :readonly          => false,
  :urlencode         => false,
  :no_block          => false,
  :buffer_request    => false
}
memcache_servers     = ['memcache.com']

# memcache caching
config.cache_store   = :libmemcached_store, memcache_servers, libmemcached_options



# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false
config.action_mailer.delivery_method = :activerecord

# Enable threaded mode
# config.threadsafe!

# Image Server Configuration
IMAGE_SERVER_APP_CODE   = 'tester'
IMAGE_SERVER            = "http://img.com"
BASE_ASSET_HOST         = "#{IMAGE_SERVER}/#{IMAGE_SERVER_APP_CODE}"
# 10.1.1.1 = INT
SOLR_SERVER = "http://10.1.1.1:8080/solr"

# 10.1.1.1:8080 = QA
SOLR_SERVER = "http://10.1.1.1:8080/solr/solrtv"

API_DJ_URI              = "http://dj01.com.com" #"http://10.1.1.1"
DJ_RANDOM_TOTAL         = 3
NEW_API_DJ              = "http://int.online.com"

GOOGLE_ANALYTICS_ID     = "UA-1234567-8"

#this is QA solr search URL, temporarily pointing here to avoid new schema changes on INT
SOLR_SEARCH_URI         = "http://10.1.1.1:8088/solr"

# this is INT solr search URL
#SOLR_SEARCH_URI         = "http://10.1.1.1:8181/solr/portal"
AN_AUTH_DOMAIN        = "localhost"

# Flash player settings
BLOCK_GOOGLE_TV         = false
SAD_ANALYTICS_SERVER  = "http://analytics.try.com"

#WHEEL stuff
WHEEL_HOST          = "http://lalala"
WHEEL_ACCOUNT_ID    = "12345"
WHEEL_PROFILE_ID    = "12323:xxxx" 
WHEEL_TOKEN         = "nice" # test account token 
WHEEL_USERNAME      = "get_home@ok"
WHEEL_PASSWORD      = "112233"

MW_URL                            = "http:/mvx.com"
MW_PROFILE                        = "tester"
MW_OAUTH_CONSUMER_KEY             = '3444555666'
MW_OAUTH_SHARED_SECRET            = '4466779900'

# SOME Analytics Settings.
SOME_ANALYTICS_URI = "analytics.com"

# Other counting - they must be all kept in sync!
WV_LICENCE_SERVERS    = ["http://licence.com/"]

# Flash player settings
BLOCK_GOOGLE_TV         = false
OTHER_ANALYTICS_SERVER  = "http://nalytics..com"

BUSTER_RSS       = "http://buster.com"
BUSTER_URL       = "https://sbuster.com"
BUSTER_UPGRADE   = "hhttps://abuster.com"
BUSTER_SIGNUP           = "https://xbuster.com"
BUSTER_ORDER     = "https://vbuster.com"
BUSTER_ONLINE_ID = "https://nbuster.com"

SP_PLUGIN           = "http://plugin.com/install.js"

# Selective External Asset Checking
ActionController::Base.asset_host = Proc.new { |source, request|
  
  # This app server has many images versioned. Some images however live outside
  # the scope of this application. In that case, look for them on that app server.
  if source[0..4] == "/imx"
    "http://img#{rand(4)+1}.com"
  end
}

ACCOUNT_STATUS_EMAIL_ADDRESSES = ["mail@me.com", "mail@you.com"]
SOME_WEB_SERVICE_URL = "https://your.identity.com/invoke/test.it_all.v1/"

SECURE_CERT = "/var/certifs/some.pem"
SECURE_CERT_KEY = "/var/certifs/some.key"
SECURE_SERVER = "https://secure..com:444/"
