  { ... }:
  {
    programs.tmux = {
      enable = true;
      mouse = true;
      keyMode = "vi";
      prefix = "C-a";
      extraConfig = ''
        bind-key | split-window -h
        bind-key - split-window -v
        unbind '"'
        unbind %

        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R

        bind-key -r C-h resize-pane -L 5
        bind-key -r C-j resize-pane -D 5
        bind-key -r C-k resize-pane -U 5
        bind-key -r C-l resize-pane -R 5

      '';
    };
}
