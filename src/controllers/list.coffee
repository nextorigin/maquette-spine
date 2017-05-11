Spine    = require "spine"
Maquette = require "maquette"
Mapper   = require "maquette-mapper"


class ListController extends Spine.Controller
  logPrefix: "(Maquette-Spine-ListController)"

  _attrsFromElement: (el) ->
    attrs       = {}
    $el         = $ el
    attrs[attr] = $child.val() for attr in @Store.attributes when ($child = $el.find ".#{attr}").length
    attrs

  _idFromEvent: (e) ->
    @_idFromElement @_targetFromEvent e

  _idFromElement: ($el) ->
    $el.data().id

  _targetFromEvent: (e) ->
    ($ e.target).closest ".#{@Store.className.toLowerCase()}"

  create: (e) ->
    $el      = @_targetFromEvent e
    attrs    = @_attrsFromElement $el
    record   = new @Store attrs
    record.save()
    @reset $el

  reset: (el) ->
    $el        = $ el
    {defaults} = @Store
    defaults or= {}
    $child.val (defaults[attr] or "") for attr in @Store.attributes when ($child = $el.find ".#{attr}").length

  update: (e) ->
    $el      = @_targetFromEvent e
    id       = @_idFromElement $el
    attrs    = @_attrsFromElement $el
    record   = @Store.find id
    record?.update attrs

  delete: (e) ->
    id = @_idFromEvent e
    @Store.destroy id

  constructor: ->
    super

    required = [
      "el"
      "Store"
      "view"
      "itemView"
    ]
    throw new Error "#{option} required" for option in required when not @[option]?

    @projector or= Maquette.createProjector()
    @itemMap     = new Mapper [], @itemView

    @bindEvents()
    @attachRenderer()

  bindEvents: ->
    @Store.on "error", @error
    @Store.on "refresh change", @projector.scheduleRender

  attachRenderer: ->
    @projector.append @el[0], @render

  render: (items = @Store.all()) =>
    @log "rendering"

    @itemMap.update items
    @view {items: @itemMap.components}

  load: ->
    @Store.fetch()

  error: (args...) =>
    console.error args...


module.exports = ListController
