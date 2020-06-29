# docker-emacs
Dockerized Emacs environment

## Features
- Launch Emacs 27 on container based on Ubuntu 18.04 (use [silex/emacs:27.0](https://github.com/Silex/docker-emacs/blob/master/27.0/ubuntu/18.04/Dockerfile))
- Pre-install some LSP servers (for [lsp-mode](https://github.com/emacs-lsp/lsp-mode))

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

```shell
$ git clone https://github.com/medalotte/docker-emacs.git
$ cd docker-emacs
$ docker-compose build
$ cp -R [your .emacs.d] ./home # Please set your emacs configuration. In my case: `$ git clone https://github.com/medalotte/.emacs.d.git ./home`
$ export DOCKER_EMACS_PRJ=[a project root you want to edit by docker-emacs]
$ xhost + local:root
$ docker-compose run --rm docker-emacs
```

After doing the above, the home directory (`/root`) in the container should look like this:

```shell
/root
├── prj         # a project root you set DOCKER_EMACS_PRJ
├── .emacs.d    # Your Emacs configuration
└── .Xauthority # for X11 auth
```

## Tips
### Launch Emacs as CUI
You have to press Ctrl-p twice because of setting of `detachKey` when launch emacs as CUI.  
It is necessary to change the setting of `detachKey` in order to solve it.  
Please update `~/.docker/config.json` as following:

```json
{
    "detachKeys": "ctrl-\\"
}
```

Note that the following requirements must be met for this setting to take effect:

- **Docker** 1.10.0 or higher
- **Docker Compose** 1.20.0 or higher
