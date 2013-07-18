user "search" do
  action :create
  home "/home/search"
  shell "/bin/bash"
  supports :manage_home => true
end

package "openjdk-7-jre"

directory "/home/search/data" do
  owner "search"
  group "search"
  mode "0755"
  action :create
end

directory "/home/search/data/new" do
  owner "search"
  group "search"
  mode "0755"
  action :create
end

directory "/home/search/data/cur" do
  owner "search"
  group "search"
  mode "0755"
  action :create
end

directory "/home/search/data/old" do
  owner "search"
  group "search"
  mode "0755"
  action :create
end

directory "/home/search/jar" do
  owner "search"
  group "search"
  mode "0755"
  action :create
end

directory "/home/search/bin" do
  owner "search"
  group "search"
  mode "0755"
  action :create
end

# TODO: Change to download this from our site or build it in place
cookbook_file "/home/search/jar/index.jar" do
  source "index.jar"
  group "search"
  owner "search"
  mode "0644"
end

cookbook_file "/home/search/bin/reindex" do
  source "reindex"
  group "search"
  owner "search"
  mode "0755"
end

package "jetty"
