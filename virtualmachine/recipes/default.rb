user "postgres"

bash "partition /dev/sdb if necessary" do
  user "root"
  code <<-EOH
  if [ ! -b /dev/sdb1 ]; then
    sudo parted -s /dev/sdb mklabel msdos
    sudo parted -s /dev/sdb -- mkpart primary 1 '-1'
    sudo partprobe
    sudo mkfs.ext4 -q /dev/sdb1 2>/dev/null
  fi
  EOH
end 

directory "/var/lib/postgresql" do
  group "postgres"
  user "postgres"
end

mount "/var/lib/postgresql" do
  device "/dev/sdb1"
end

package "curl"
package "wget"
