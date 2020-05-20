{ config, lib, ... }:

{
  options.psql.historyDir = lib.mkOption {
    type = lib.types.path;
    default = "${config.xdg.dataHome}/psql_history";
    defaultText = "$XDG_DATA_HOME/psql_history";
    description = ''
      Absolute path to directory holding psql history.
    '';
  };
}
