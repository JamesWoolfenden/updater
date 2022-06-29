INSERT INTO platform2.incident_configurations (
	incident_id, incident_type, category, title, guideline, severity, lacework_violation_id, prowler_violation_id, checkov_check_id, remediation_ids, condition_query, is_custom, customer_name, resource_types, provider, created_by, code, constructive_title, descriptive_title, pc_policy_id, frameworks, pc_severity, source_incident_id, additional_pc_policy_ids) 
	VALUES ('BC_AWS_997', 'Violation', 'General', 'Test Title', 'url to guideine', 
	'MEDIUM', NULL, NULL, 'CKV_AWS_997',
	'{}', NULL, true, 'james', '{aws_security_group}', 'AWS', NULL, NULL,
	 'constuctive', 'descriptive', NULL, '{Terraform}', NULL, NULL, NULL);
