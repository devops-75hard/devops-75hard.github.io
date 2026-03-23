# Flatten all ingress rules into a single map so we can use for_each.
# Key format: "sg_name-rule_name" e.g. "application1-allow-lb"
locals {
  ingress_rules = {
    for pair in flatten([
      for sg_key, sg in var.security_groups : [
        for rule_key, rule in sg.ingress_rules : {
          key    = "${sg_key}-${rule_key}"
          sg_key = sg_key
          rule   = rule
        }
      ]
    ]) : pair.key => pair
  }

  # Same flattening for egress rules
  egress_rules = {
    for pair in flatten([
      for sg_key, sg in var.security_groups : [
        for rule_key, rule in sg.egress_rules : {
          key    = "${sg_key}-${rule_key}"
          sg_key = sg_key
          rule   = rule
        }
      ]
    ]) : pair.key => pair
  }
}
