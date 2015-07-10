require 'serverspec'
set :backend, :cmd
set :os, family: 'windows'

describe windows_registry_key(
  'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Common'
) do
  it { should exist }
end
