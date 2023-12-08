resource "azurerm_policy_definition" "sa-policy" {
  name         = "sa-policy"
  display_name = "Storage Account Policy"
  description  = "This policy ensures that all storage accounts have proper security settings configured"
  policy_type  = "Custom"
  mode = "Indexed"
    metadata = <<METADATA
    {
        "category": "Storage"
    }
    METADATA    
    resource "azurerm_policy_definition" "sa-policy" {
        name         = "sa-policy"
        display_name = "Storage Account Policy"
        description  = "This policy ensures that all storage accounts have Secure transfer enabled."
        policy_type  = "Custom"
        mode         = "Indexed"
        metadata = <<METADATA
            {
                    "category": "Storage"
            }
        METADATA

        policy_rule = <<POLICY_RULE
            {
                    "if": {
                            "field": "type",
                            "equals": "Microsoft.Storage/storageAccounts"
                    },
                    "then": {
                            "effect": "audit",
                            "details": {
                                    "type": "Microsoft.Storage/storageAccounts/secureTransfer",
                                    "existenceCondition": {
                                            "field": "Microsoft.Storage/storageAccounts/enableHttpsTrafficOnly",
                                            "equals": "true"
                                    }
                            }
                    }
            }
        POLICY_RULE
    }
            "if": {
                "field": "type",
                "equals": "Microsoft.Storage/storageAccounts"
            },
            "then": {
                "effect": "auditIfNotExists",
                "details": {
                    "type": "Microsoft.Storage/storageAccounts/networkAcls/defaultAction",
                    "existenceCondition": {
                        "field": "Microsoft.Storage/storageAccounts/networkAcls/defaultAction",
                        "equals": "Allow"
                    }
                }
            }
        }
    POLICY_RULE
