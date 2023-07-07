{
  description = "Home Manager configuration";

  inputs = {
    home-manager-config.url = "github:suned/home-manager-config";
  };

  outputs = { home-manager-config, ... }:
    let
      # TODO update these to actual values
      username = "username";
      email = "your.email@host.com";
    in
    {
      homeConfigurations."${username}" = home-manager-config.mkConfiguration { inherit username email; };
    };
}
