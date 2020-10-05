{ lib, pkgs, config, ... }: let cfg = config.services.hello; in {
  options.services.hello = {
    enable = lib.mkEnableOption "a program which displays a greeting";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hello;
    };
  };
  config.systemd.services.hello = lib.mkIf cfg.enable {
    path = [ cfg.package ];
    serviceConfig.Type = "oneshot";
    script = "hello";
  };
}
