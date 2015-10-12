#
# Author:: Mikhail Zholobov
# Cookbook Name:: msoffice
# Recipe:: install
#
# Copyright 2014, Mikhail Zholobov.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Ensure seven_zip is installed
include_recipe 'seven_zip::default'

# Ensure the installation ISO url has been set by the user
if node['msoffice']['source'].nil?
  fail "'msoffice source' attribute must be set before running this cookbook"
end

edition = node['msoffice']['edition']
version = node['msoffice']['version']
install_url = File.join(node['msoffice']['source'], node['msoffice'][edition]['filename'])
checksum = node['msoffice'][edition]['checksum']
msoffice_package_name = node['msoffice'][edition]['package_name']

seven_zip_exe = File.join(node['seven_zip']['home'], '7z.exe')
iso_extraction_dir = win_friendly_path(File.join(Dir.tmpdir, 'msoffice2013'))
setup_exe_path = File.join(iso_extraction_dir, 'setup.exe')
config_xml_file = win_friendly_path(File.join(iso_extraction_dir, 'Config.xml'))

msoffice_is_installed = registry_key_exists?(node['msoffice']['registrykey'][version], :x86_64)

if msoffice_is_installed
  log "#{msoffice_package_name} is already installed. Skipping..."
else
  # Download ISO to local file cache, or just use if local path
  local_iso_path = cached_file(install_url, checksum)

  # Create the extraction tmp dir
  directory iso_extraction_dir do
    recursive true
    action :create
  end

  # Extract the ISO image to the tmp dir
  execute 'extract_msoffice_iso' do
    command "#{seven_zip_exe} x -y -o#{iso_extraction_dir} #{local_iso_path}"
  end

  # Create installation config file
  template config_xml_file do
    source 'Config-' + edition + '.erb'
    variables(
      pid_key: node['msoffice']['pid_key'],
      auto_activate: node['msoffice']['auto_activate']
    )
  end

  # Install Microsoft Office
  windows_package msoffice_package_name do
    source setup_exe_path
    installer_type :custom
    options "/config \"#{config_xml_file}\""
    notifies :delete, "directory[#{iso_extraction_dir}]"
    timeout 1200 # 20minutes
  end
end
