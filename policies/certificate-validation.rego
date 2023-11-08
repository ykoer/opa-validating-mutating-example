package kubernetes.certmanager.issuer.rhcs.admission

deny[msg] {
	input.request.kind.kind == "Certificate"
	input.request.object.spec.issuerRef.group == "cert-manager.io"
	input.request.object.spec.issuerRef.kind == "ClusterIssuer"
	input.request.object.spec.issuerRef.name == "rhcs-issuer-user"

	certificate := input.request.object
	certificate.spec.subject.organizations[_] != "mpaas"
	msg := sprintf("O=mpaas' should be in the subject, namespace=%v, name=%v", [certificate.metadata.namespace, certificate.metadata.name])
}
deny[msg] {
	input.request.kind.kind == "Certificate"
	input.request.object.spec.issuerRef.group == "cert-manager.io"
	input.request.object.spec.issuerRef.kind == "ClusterIssuer"
	input.request.object.spec.issuerRef.name == "rhcs-issuer-user"

	certificate := input.request.object
	certificate.spec.subject.organizationalUnits[_] != "serviceaccounts"
	msg := sprintf("OU=serviceaccounts' should be in the subject, namespace=%v, name=%v", [certificate.metadata.namespace, certificate.metadata.name])
}

# deny[msg] {
# 	input.request.kind.kind == "Secret"
# 	secret := input.request.object
# 	secret.metadata.name == "test-secret"
# 	msg := sprintf("YESSSSSSS, namespace=%v, name=%v", [secret.metadata.namespace, secret.metadata.name])
# }