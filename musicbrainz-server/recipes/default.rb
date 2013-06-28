user "musicbrainz" do
  action :create
  home "/home/musicbrainz"
  shell "/bin/bash"
  supports :manage_home => true
end

package "git"

git "/home/musicbrainz/musicbrainz-server" do
  repository "git://github.com/metabrainz/musicbrainz-server.git"
  revision "master"
  action :sync
  user "musicbrainz"
  revision node['musicbrainz-server']['revision']
end

cookbook_file "/home/musicbrainz/musicbrainz-server/lib/DBDefs.pm" do
  source "DBDefs.pm"
  owner "musicbrainz"
  mode "644"
end

apt_repository "musicbrainz" do
  uri "http://ppa.launchpad.net/oliver-charles/musicbrainz/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E4EB3B02925D4F66"
end

package "build-essential"
package "libxml2-dev"
package "libpq-dev"
package "libexpat1-dev"
package "libicu-dev"
package "libdb-dev"

package "daemontools"
package "daemontools-run"
package "svtools"

package "libalgorithm-diff-perl"
package "libalgorithm-merge-perl"
package "libauthen-passphrase-perl"
package "libcache-memcached-fast-perl"
package "libcache-memcached-perl"
package "libcache-perl"
package "libcaptcha-recaptcha-perl"
package "libcatalyst-authentication-credential-http-perl"
package "libcatalyst-modules-perl"
package "libcatalyst-perl"
package "libcatalyst-plugin-cache-http-perl"
package "libcatalyst-plugin-session-store-memcached-perl"
package "libcatalyst-plugin-unicode-encoding-perl"
package "libcatalyst-view-tt-perl"
package "libcgi-expand-perl"
package "libclone-perl"
package "libcss-minifier-perl"
package "libdata-compare-perl"
package "libdata-dumper-concise-perl"
package "libdata-optlist-perl"
package "libdata-page-perl"
package "libdata-uuid-mt-perl"
package "libdate-calc-perl"
package "libdatetime-format-duration-perl"
package "libdatetime-format-iso8601-perl"
package "libdatetime-format-natural-perl"
package "libdatetime-format-pg-perl"
package "libdatetime-timezone-perl"
package "libdbd-pg-perl"
package "libdbi-perl"
package "libdbix-connector-perl"
package "libdigest-hmac-perl"
package "libdigest-md5-file-perl"
package "libdigest-sha-perl"
package "libemail-address-perl"
package "libemail-mime-creator-perl"
package "libemail-mime-perl"
package "libemail-sender-perl"
package "libemail-valid-perl"
package "libencode-detect-perl"
package "libexception-class-perl"
package "libhtml-formhandler-perl"
package "libhtml-tiny-perl"
package "libhtml-treebuilder-xpath-perl"
package "libintl-perl"
package "libio-all-perl"
package "libjson-perl"
package "libjson-xs-perl"
package "liblist-allutils-perl"
package "liblist-moreutils-perl"
package "liblist-utilsby-perl"
package "liblog-dispatch-perl"
#package "libmath-random-secure-perl"
package "libmethod-signatures-simple-perl"
package "libmodule-pluggable-perl"
package "libmoose-perl"
package "libmoosex-abc-perl"
package "libmoosex-clone-perl"
package "libmoosex-getopt-perl"
package "libmoosex-methodattributes-perl"
package "libmoosex-role-parameterized-perl"
package "libmoosex-singleton-perl"
package "libmoosex-types-perl"
package "libmoosex-types-uri-perl"
package "libmoosex-types-structured-perl"
package "libmro-compat-perl"
package "libnet-amazon-awssign-perl"
package "libnet-amazon-s3-policy-perl"
package "libnet-coverartarchive-perl"
package "libpackage-stash-perl"
package "libreadonly-perl"
package "libredis-perl"
package "librest-utils-perl"
package "libset-scalar-perl"
package "libsoap-lite-perl"
package "libstatistics-basic-perl"
package "libstring-camelcase-perl"
package "libstring-shellquote-perl"
package "libstring-tt-perl"
package "libtemplate-plugin-class-perl"
package "libtemplate-plugin-javascript-perl"
package "libtext-trim-perl"
package "libtext-unaccent-perl"
package "libtext-wikiformat-perl"
package "libthrowable-perl"
package "libtime-duration-perl"
package "libtrycatch-perl"
#package "libunicode-icu-collator-perl"
package "liburi-perl"
package "libxml-generator-perl"
package "libxml-rss-parser-lite-perl"
package "libxml-semanticdiff-perl"
package "libxml-simple-perl"
package "libxml-xpath-perl"

service "svscan" do
  action :start
  provider Chef::Provider::Service::Upstart
end

daemontools_service "musicbrainz-server" do
  directory "/home/musicbrainz/musicbrainz-server/admin/nginx/service-standalone/"
  template false
  action [:enable,:start]
end

link "/etc/service/musicbrainz-server/mb_server" do
  to "/home/musicbrainz/musicbrainz-server"
  owner "musicbrainz"
end

script "compile_resources" do
  user "musicbrainz"
  interpreter "bash"
  cwd "/home/musicbrainz/musicbrainz-server"
  code "./script/compile_resources.pl"
end
