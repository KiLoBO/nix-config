{ ... }:
{
  flake.modules.nixos.vpn =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        tailscale
        trayscale
        netbird
      ];

      services.netbird.clients.wt0 = {
        port = 51821;
        ui.enable = true;
        openFirewall = true;
        openInternalFirewall = true;
      };

      services.tailscale.enable = true;
      services.tailscale.useRoutingFeatures = "client";
    };
}
