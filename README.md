# Tipboard docker image

## Introduction

Docker image source to run [Tipboard](http://tipboard.readthedocs.org) dashboard.

## Building docker image

```bash
git clone https://github.com/drakeu/docker-tipboard.git
cd docker-tipboard
docker build -t drakeu/tipboard .
```

## Dashboard configuration
Before run image you should prepare Tipboard configuration directory on host machine (check this [documentation](http://tipboard.readthedocs.org/en/latest/configuration.html)):

```bash
custom_tiles (directory)
layout_config.yaml
settings-local.py
```

initial layout_config.yaml example:

```yaml
details:
  page_title: Ecosystem dashboard
  layout:
    - row_1_of_2:
      - col_1_of_4:
        - tile_template: fancy_listing
          tile_id: ecosystem
          title: Ecosystem monitoring
          classes:

      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:

      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:

      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:

    - row_1_of_2:
      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:

      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:

      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:

      - col_1_of_4:
        - tile_template: empty
          tile_id: empty
          title: Empty Tile
          classes:
```

settings-local.py example:

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

PROJECT_NAME = '[PROJECT_NAME]'
API_KEY = '[YOUR_PROTECTED_KEY]'
```

You can keep that configuration structure in separate repository.

## Runing the image
Run the following command to start Tipboard:

```bash
docker run -d -p 7272:7272 -v [TIPBOARD_CONFIG_DIR]:/root/.tipboard --name=tipboard drakeu/tipboard:1.0
```

## How image works
On image exists three main applications:

- supervisor - for running redis server and tipboard dashboard
- redis - for store tipboard data
- tipboard

If you need you can connect to running image using this command:

```bash
docker exec -it tipboard bash
```

and use supervisorctl to restart redis or tipboard (for example after change key in settings-local.py).

## Using REST API for pushing data

You can use Tipboard REST API in standard way. Example:

```bash
curl -s http://localhost:7272/api/v0.1/[MY_KEY]/push -X POST -d "tile=fancy_listing" -d "key=ecosystem" -d 'data=[{"label": "CPU Load", "text": "1,15 / 8 CPU" }, {"label": "Memory", "text": "4,2G / 15G"}, {"label": "/dev/sda1", "text": "9,4G / 110G"}, {"label": "/dev/sdb1", "text": "3,3G / 19G"}, {"label": "/dev/sdb2", "text": "165G / 1,8T"}, {"label": "Swap", "text": "0B / 0B"}]'
```

You can customize port mapping in docker run command. 7272 is default Tipboard port.
