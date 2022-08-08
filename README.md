# Template for Haskell + Nix projects.

A simplified Haskell + Nix project template and tutorial forked from [template-haskell](https://github.com/jonascarpay/template-haskell).

Uses IOG's [`haskell.nix`](https://github.com/input-output-hk/haskell.nix) for setting up an environment containing `ghc`, `cabal`, `hoogle`, and `haskell-language-server`.

## Install Nix
Start by [installing Nix](https://nixos.org/download.html) for your operating system.

## Install Flakes
1. Install `nixFlakes` in your environment with the following command:
    ```bash
    $ nix-env -iA nixpkgs.nixFlakes
    ```
2. Edit either `~/.config/nix/nix.conf` or `/etc/nix/nix.conf` and add the following line:
    ```text
    experimental-features = nix-command flakes
    ```

**Note:** if you installed Nix in multi-user mode in the previous section, you'll need to restart the nix-daemon:

  ```bash
  $ sudo systemctl restart nix-daemon
  ```

[Reference](https://nixos.wiki/wiki/Flakes#Non-NixOS)

## Create Repository from Template
1. Click the green `Use this template` button at the top right of this repository page, name your project, and click `Create repository from template`.
2. Click the `Code` dropdown button on your repository page and copy the **HTTPS** link.
3. In a terminal window, enter the directory where you'd like your project to be stored and enter the following, pasting in your repository URL:
    ```bash
    $ git clone https://github.com/<your github username>/<your project name>.git
    ```

## Run Wizard to Configure Project
1. In your terminal, enter your project directory (i.e. `$ cd <your project name>/`) and run the following command to start the wizard script:
    ```bash
    $ ./wizard.sh
    ```
2. Respond to the prompts as follows:
  * `Package name [<your project name>]:` hit `ENTER` to accept the default.
  * `Author name [<your name>]:` hit `ENTER` to accept the default.
  * `Author email [<your email>]:` hit `ENTER` to accept the default.
  * `Reinitialize git history? [Y/n]?` type `n` and `ENTER`.

3. Stage, commit and push your changes:
    ```bash
    $ git add -A
    $ git commit -m "Set up project"
    $ git push
    ```
