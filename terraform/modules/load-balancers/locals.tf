locals {
  listeners = {
    for pair in flatten([
      for lb_key, lb in var.load_balancers : [
        for listener_key, listener in lb.listeners : {
          key          = "${lb_key}-${listener_key}"
          lb_key       = lb_key
          listener_key = listener_key
          listener     = listener
        }
      ]
    ]) : pair.key => pair
  }

  rules = {
    for pair in flatten([
      for lb_key, lb in var.load_balancers : [
        for listener_key, listener in lb.listeners : [
          for rule_key, rule in listener.rules : {
            key          = "${lb_key}-${listener_key}-${rule_key}"
            lb_key       = lb_key
            listener_key = listener_key
            rule         = rule
          }
        ]
      ]
    ]) : pair.key => pair
  }
}
