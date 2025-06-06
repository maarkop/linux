{ ... } : {
  services.syncthing = {
    enable = true;
    user = "marko";
    group = "users";
    openDefaultPorts = true;
  };
}
