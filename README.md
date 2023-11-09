# OPA validating and mutating example

## Links

* [https://github.com/orgs/open-policy-agent/discussions/219](https://github.com/orgs/open-policy-agent/discussions/219)
* [https://github.com/open-policy-agent/opa-envoy-plugin/blob/de4182f08bd29d984cbeb88056e82e2b8b74c30d/examples/istio/quick_start.yaml#L275](https://github.com/open-policy-agent/opa-envoy-plugin/blob/de4182f08bd29d984cbeb88056e82e2b8b74c30d/examples/istio/quick_start.yaml#L275)
* [https://github.com/naeemarsalan/opa-http-env-inject/blob/94982e96d9c24d8b4205a324020494749e21b120/deploy/script/webhook-create-signed-cert.sh](https://github.com/naeemarsalan/opa-http-env-inject/blob/94982e96d9c24d8b4205a324020494749e21b120/deploy/script/webhook-create-signed-cert.sh)
* [https://github.com/tmobile/magtape/blob/046017a1d2d6f090e7d74a4f7776375e4c20ed8a/deploy/install.yaml#L140](https://github.com/tmobile/magtape/blob/046017a1d2d6f090e7d74a4f7776375e4c20ed8a/deploy/install.yaml#L140])
* [https://github.com/tsandall/validating-and-mutating-example](https://github.com/tsandall/validating-and-mutating-example)
* [https://play.openpolicyagent.org/p/lttuKeuUpW](https://play.openpolicyagent.org/p/lttuKeuUpW)
* [https://play.openpolicyagent.org/p/lttuKeuUpW](https://play.openpolicyagent.org/p/lttuKeuUpW)
* [https://play.openpolicyagent.org/p/vkp11dExtK](https://play.openpolicyagent.org/p/vkp11dExtK)


## OPA Command Examples

```bash
opa run --server \
--log-format text \
--set decision_logs.console=true \
--set bundles.play.polling.long_polling_timeout_seconds=45 \
--set services.play.url=https://play.openpolicyagent.org \
--set bundles.play.resource=bundles/jw1mTumCjH
```

```bash
opa run --server \
--log-format text \
--set decision_logs.console=true \
--set bundles.play.polling.long_polling_timeout_seconds=45 \
--set bundles.default.resource=policies/bundle.tar.gz 
```

```bash
opa run -s \
--log-format text \
--set decision_logs.console=true \
--set bundles.default.resource=policies/bundle.tar.gz 
--set bundles.default.polling.min_delay_seconds=3 
--set bundles.default.polling.max_delay_seconds=5
```

```bash
opa run \
--server \
--addr=http://127.0.0.1:8181 \
--set=services.default.url=http://host.minikube.internal:8888 \
--set=bundles.default.resource=bundle.tar.gz \
--set=default_decision=kubernetes/admission/main \
--log-format=json-pretty \
--set=status.console=false \
--set=decision_logs.console=false
```

```bash
opa eval -b policies -i input-invalid.json 'data.kubernetes.admission.main'
```

## AdmissionReview Input

input-invalid.json:

```json
{
  "apiVersion": "admission.k8s.io/v1",
  "kind": "AdmissionReview",
  "request": {
    "dryRun": false,
    "kind": {
      "group": "cert-manager.io",
      "kind": "Certificate",
      "version": "v1"
    },
    "name": "cert-user-invalid-o-ou",
    "namespace": "default",
    "object": {
      "apiVersion": "cert-manager.io/v1",
      "kind": "Certificate",
      "metadata": {
        "creationTimestamp": "2023-11-08T14:06:48Z",
        "generation": 1,
        "name": "cert-user-invalid-o-ou",
        "namespace": "default",
        "uid": "5d8d75a1-5cc2-41c8-8e94-718a614172b7"
      },
      "spec": {
        "commonName": "cert1",
        "isCA": true,
        "issuerRef": {
          "group": "cert-manager.io",
          "kind": "ClusterIssuer",
          "name": "rhcs-issuer-user"
        },
        "privateKey": {
          "algorithm": "ECDSA",
          "size": 384
        },
        "secretName": "cert-user-invalid-o-ou",
        "subject": {
          "organizationalUnits": [
            "serviceaccounts"
          ],
          "organizations": [
            "other"
          ]
        }
      }
    },
    "oldObject": null,
    "operation": "CREATE",
    "options": {
      "apiVersion": "meta.k8s.io/v1",
      "fieldManager": "kubectl-client-side-apply",
      "kind": "CreateOptions"
    },
    "requestKind": {
      "group": "cert-manager.io",
      "kind": "Certificate",
      "version": "v1"
    },
    "requestResource": {
      "group": "cert-manager.io",
      "resource": "certificates",
      "version": "v1"
    },
    "resource": {
      "group": "cert-manager.io",
      "resource": "certificates",
      "version": "v1"
    },
    "uid": "c57f69df-8f1e-4c70-8abc-17a0b4e376cd",
    "userInfo": {
      "groups": [
        "system:masters",
        "system:authenticated"
      ],
      "username": "minikube-user"
    }
  }
}
```