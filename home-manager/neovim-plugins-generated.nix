# GENERATED by ./pkgs/applications/editors/vim/plugins/update.py. Do not edit!
{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  baleia-nvim = buildVimPlugin {
    pname = "baleia.nvim";
    version = "2023-04-18";
    src = fetchFromGitHub {
      owner = "m00qek";
      repo = "baleia.nvim";
      rev = "00bb4af31c8c3865b735d40ebefa6c3f07b2dd16";
      sha256 = "1wckhdwdzip8v4da6fnmikpvi921aa88qv83261wl7dxw9nvnx21";
      fetchSubmodules = true;
    };
    meta.homepage = "https://github.com/m00qek/baleia.nvim/";
  };

  nterm-nvim = buildVimPlugin {
    pname = "nterm.nvim";
    version = "2022-05-10";
    src = fetchFromGitHub {
      owner = "jlesquembre";
      repo = "nterm.nvim";
      rev = "cd7b7035d09144ee4ea49244bf5cb8ed68e499f8";
      sha256 = "0cvg03d1z7jkamg062ng731pdmckrdm611q24brr9ha1qc5q26gm";
    };
    meta.homepage = "https://github.com/jlesquembre/nterm.nvim/";
  };


}
