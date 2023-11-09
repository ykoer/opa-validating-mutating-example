package kubernetes.admission
# import data.system

# ------------------------------------------------------------------------------------------------------------------ #
#                                                   Mutating Policies                                                #
# ------------------------------------------------------------------------------------------------------------------ #

patch[patchCode] {
	isValidRequest
	isCreateOrUpdate
	input.request.kind.kind == "Certificate"
	input.request.object.spec.privateKey.algorithm != "ECDSA"
	
    patchCode = {
		"op": "replace",
		"path": "/spec/privateKey/algorithm",
		"value": "ECDSA",
	}

	# log_msg := "########################"
    # print(log_msg, {"severity": "info"})
}


patch[patchCode] {
	isValidRequest
	isCreateOrUpdate
	input.request.kind.kind == "Certificate"
	input.request.object.spec.privateKey.size != 384
	
    patchCode = {
		"op": "replace",
		"path": "/spec/privateKey/size",
		"value": 384,
	}
}

