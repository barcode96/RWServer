resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependencies {
  "vrp"
}

shared_script "@evp/main.lua"

client_scripts {
  "@vrp/client/Proxy.lua",
  "@vrp/client/Tunnel.lua",
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "server.lua"
}
