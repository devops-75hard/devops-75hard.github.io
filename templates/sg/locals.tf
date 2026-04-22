locals {
  ingress_rules = merge([
    for sg_key, sg in var.security_groups : {
      for rule_key, rule in sg.ingress_rules :
      "${sg_key}-${rule_key}" => merge(rule, { sg_key = sg_key })
    }
  ]...)

  egress_rules = merge([
    for sg_key, sg in var.security_groups : {
      for rule_key, rule in sg.egress_rules :
      "${sg_key}-${rule_key}" => merge(rule, { sg_key = sg_key })
    }
  ]...)
}
