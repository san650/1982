                           :::   ::::::::   ::::::::   ::::::::
                         :+:+:  :+:    :+: :+:    :+: :+:    :+:
                           +:+  +:+    +:+ +:+    +:+       +:+
                           +#+   +#++:++#+  +#++:++#      +#+
                           +#+         +#+ +#+    +#+   +#+
                           #+#  #+#    #+# #+#    #+#  #+#
                         ####### ########   ########  ##########

                                    Blog generator

The idea is to create a simple blog generator using POSIX tools almost
exclusively (except for the `markdown` conversion tool).

## Installation

Dependencies

* Makefile
* m4
* sed
* markdown

## Usage

To create a new post run

```sh
$ make new_post TITLE="My awesome post" AUTHOR="Santiago Ferreira"
```

Write your post and then generate the site

```sh
$ make build
```

This command will generate a `dist/` folder with all your posts.

## Customization

TBA

## License

1982 is licensed under the MIT license.

See [LICENSE](./LICENSE) for the full license text.
