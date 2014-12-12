
exports.time = (a, b) ->
  (new Date a.time) - (new Date b.time)

exports.timeReverse = (a, b) ->
  (new Date b.time) - (new Date a.time)