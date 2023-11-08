package system

import data.kubernetes.certmanager.issuer.rhcs.admission

main := {
  "apiVersion": "admission.k8s.io/v1",
  "kind": "AdmissionReview",
  "response": response,
}

default uid := ""

uid := input.request.uid

response := {
    "allowed": false,
    "uid": uid,
    "status": {
        "message": reason,
    },
} {
    reason = concat(", ", admission.deny)
    reason != ""
}

else := {"allowed": true, "uid": uid}
