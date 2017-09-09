# maquette-spine

[![Greenkeeper badge](https://badges.greenkeeper.io/nextorigin/maquette-spine.svg)](https://greenkeeper.io/)

[![Dependency Status][dependency]][david]
[![devDependency Status][dev-dependency]][david-dev]
[![Downloads][downloads]][npm]

Widget base classes for Spine Controllers+Models rendered through Maquette views

[![NPM][npm-stats]][npm]

## Installation
```sh
npm install --save-dev maquette-spine
```

## Usage -- ListController

A helper controller for common usage of [maquette-mapper][maquette-mapper].

#### Example: el-borracho-ui + gulp-pug-hyperscript

##### Model [filter.coffee](https://github.com/nextorigin/el-borracho-ui/blob/master/src/models/filter.coffee)
```coffee
class Filter extends Spine.Model
  @configure "Filter",
    "type",
    "value"
```

##### View [filter.jade](https://github.com/nextorigin/el-borracho-ui/blob/master/src/views/filter.jade)
```coffee
li(class="filter #{type}" id="filter-#{id}" key=id)
  h6 #{type}:
    span.value= value
  button.icon.delete(title="delete") Â
```

##### [filters.jade](https://github.com/nextorigin/el-borracho-ui/blob/master/src/views/filters.jade)
```coffee
ul!= filters()
```

##### Controller
```coffee
ListController = require "maquette-spine/controllers/list"


class ExampleController extends ListController
  constructor: (options) ->
    jQuery.extend options,
      Store:       require "../models/filter"
      view:        require "../views/filters"
      itemView:    require "../views/filter"

    super

```

## License

MIT

  [maquette-mapper]: https://github.com/nextorigin/maquette-mapper
  
  [dependency]: https://img.shields.io/david/nextorigin/maquette-spine.svg?style=flat-square
  [david]: https://david-dm.org/nextorigin/maquette-spine
  [dev-dependency]: https://img.shields.io/david/dev/nextorigin/maquette-spine.svg?style=flat-square
  [david-dev]: https://david-dm.org/nextorigin/maquette-spine?type=dev
  [downloads]: https://img.shields.io/npm/dm/maquette-spine.svg?style=flat-square
  [npm]: https://www.npmjs.org/package/maquette-spine
  [npm-stats]: https://nodei.co/npm/maquette-spine.png?downloads=true&downloadRank=true&stars=true
