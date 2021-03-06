# docker-emacs
Dockerized Emacs environment including some LSP servers

## Features
- Launch Emacs 27.1 on a container based on Ubuntu 18.04 by [silex/emacs:27.1](https://github.com/Silex/docker-emacs/blob/master/27.1/ubuntu/18.04/Dockerfile)
- Preinstall some tools for Emacs extensions
- Preinstall some LSP servers for [lsp-mode](https://github.com/emacs-lsp/lsp-mode)

| Language              | LSP server                                                                                             |
|:----------------------|:-------------------------------------------------------------------------------------------------------|
| C/C++/Object-C        | [ccls](https://github.com/MaskRay/ccls)                                                                |
| Python                | [pyls](https://github.com/palantir/python-language-server)                                             |
| Bash                  | [bash-language-server](https://github.com/bash-lsp/bash-language-server)                               |
| Dockerfile            | [dockerfile-language-server-nodejs](https://github.com/rcjsuen/dockerfile-language-server-nodejs)      |
| HTML                  | [vscode-html-languageserver-bin](https://github.com/vscode-langservers/vscode-html-languageserver-bin) |
| CSS                   | [vscode-css-languageserver-bin](https://github.com/vscode-langservers/vscode-css-languageserver-bin)   |
| JavaScript/TypeScript | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                  |

## Usage
Please setup the container with following commands:

```shell
$ git clone https://github.com/medalotte/docker-emacs.git
$ cd docker-emacs
$ docker-compose build
$ export DOCKER_EMACS_PRJ=[a project root you want to edit by docker-emacs]
```

After that, you can launch Emacs on the container with the following command:

```shell
$ docker-compose run -u "$(id -u $USER):$(id -g $USER)" --rm docker-emacs
```

The home directory in the container looks like this:

```shell
/$HOME
├── prj           # the project that you set DOCKER_EMACS_PRJ
├── .emacs.d      # Emacs configuration
├── .bashrc       # including Starship configuration
└── .Xauthority   # for X11 auth
```

## Tips
### Easy to launch `docker-emacs`
You can easily launch `docker-emacs` by setting `DOCKER_EMACS_PRJ` and alias to `.bashrc` with the following command:

```shell
$ cat <<EOF >> ~/.bashrc
export DOCKER_EMACS_PRJ=[specific directory]
alias docker-emacs='cd [absolute path of this repository] && docker-compose run -u "\$(id -u \$USER):\$(id -g \$USER)" --rm docker-emacs && cd -'
EOF
```

You can launch `docker-emacs` from any directory with the following command:

```shell
$ docker-emacs
```

### Launch Emacs as CUI
If Emacs is invoked with CUI, you have to press `C-p` twice to move the cursor up.
It is necessary to change the setting of `detachKey` to avoid the above problem.
Please update `~/.docker/config.json` as the following:

```json
{
    "detachKeys": "ctrl-\\"
}
```

Note that the following requirements must be met for the solution to take effect:

- **Docker:** ver.1.10.0 or higher
- **Docker Compose:** ver.1.20.0 or higher
