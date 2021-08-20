{
  programs.git = {
    enable = true;
    userName  = "Toby Slight";
    userEmail = "tslight@pm.me";
    aliases = {
      a = "add";
      aa = "add -A";
      ba = "branch -a";
      bd = "branch -d";
      b = "branch";
      c = "commit";
      ca = "commit -a";
      cl = "clone";
      cm = "commit -m";
      co = "checkout";
      l = "log --graph --decorate --pretty=oneline --abbrev-commit";
      m = "merge";
      P = "pull";
      p = "push";
      pa = "push --all -u";
      pm = "push origin master";
      po = "push origin";
      rb = "rebase";
      rv = "revert";
      r = "remote";
      s = "status";
      ua = "remote set-url --add --push origin";
      ud = "remote set-url --delete --push origin";
    };
    ignores = [
      "*~"
      "*.swp"
    ];
    extraConfig = {
      core = {
        autocrlf = false;
        whitespace = "trailing-space,space-before-tab";
      };
    };
  };
}
