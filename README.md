# LogStreamTool

LogStreamTool is a Crystal application for streaming and monitoring logs from Kubernetes pods. It allows you to easily stream logs from a specific pod to your favorite text editor.

## Features

- Stream logs from a Kubernetes pod.
- Choose your preferred text editor (vim, neovim, code, etc.).
- Seamless integration with Kubernetes.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Installation

download from release pre-built and run:

```shell
# chmod +x if need it
./logstream

### Prerequisites

Make sure you have Kubernetes CLI (`kubectl`) installed on your system.

### Build the Application

```shell
git clone https://github.com/DmarshalTU/LogStreamToo.cr.git

cd logstream-tool

shards build --release
```

## Usage

```shell
./logstream --namespace mynamespace --pod-name mypod --editor vim

### Options

--namespace: Specify the Kubernetes namespace (default: default).
--pod-name: Specify the pod name (default: nginx).
--editor: Choose your text editor (vim, neovim, code, etc.).
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/dmarshaltu/logstreamtool/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Denis Tu](https://github.com/dmarshaltu) - creator and maintainer
