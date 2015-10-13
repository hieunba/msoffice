#
# Author:: Mikhail Zholobov
# Cookbook Name:: msoffice
# Attribute:: default
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

default['msoffice']['edition'] = 'professional' # other editions are not supported yet
default['msoffice']['version'] = '64bit' # or '32bit'

# Set this attribute to the your Product Key, or keep it nil to activate manually
default['msoffice']['pid_key'] = nil

# Set this attribute to the true if you want to activate MS Office automatically
default['msoffice']['auto_activate'] = false

# Set this attribute yourself to the FQDN of the folder which contains the ISO
# default['msoffice']['source'] = 'http://example.com:8080/msoffice'

# MS Office 2013
default['msoffice']['professional']['package_name'] = 'Microsoft Office Professional Plus 2013'
default['msoffice']['professional']['filename'] = 'en_office_professional_plus_2013_x64_dvd_1123674.iso'
default['msoffice']['professional']['checksum'] = '2a31129a9d85896baf3eaf0a9380232cb16de0fb339675fe2405be22852612b0'

# Currently you cannot change this, doing so will break the cookbook
default['msoffice']['registrykey']['64bit'] = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common'
default['msoffice']['registrykey']['32bit'] = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\Common'
