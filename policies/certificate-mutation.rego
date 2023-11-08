package kubernetes.certmanager.issuer.rhcs.admission

# ------------------------------------------------------------------------------------------------------------------ #
#                                                   Mutating Policies                                                #
# ------------------------------------------------------------------------------------------------------------------ #

patch[patchCode] {
	# isValidRequest
	# isCreateOrUpdate
	input.request.kind.kind == "Certificate"
	input.request.object.spec.privateKey.algorithm != "ECDSA"
	
    patchCode = {
		"op": "replace",
		"path": "/spec/privateKey/algorithm",
		"value": "ECDSA",
	}

	log_msg := "########################"
    print(log_msg, {"severity": "info"})

}
