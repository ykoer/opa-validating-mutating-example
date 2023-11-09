opa eval -b ../policies -i input-invalid-o.json 'data.kubernetes.admission.main'
opa eval -b ../policies -i input-invalid-ou.json 'data.kubernetes.admission.main'
opa eval -b ../policies -i input-invalid-o-ou.json 'data.kubernetes.admission.main'
opa eval -b ../policies -i input-valid.json 'data.kubernetes.admission.main'

# Expected
# [{"op":"replace","path":"/spec/privateKey/algorithm","value":"ECDSA"},{"op":"replace","path":"/spec/privateKey/size","value":384}]
opa eval -b ../policies -i input-invalid-privatekey.json 'data.kubernetes.admission.main' | jq -r '.result[0].expressions[0].value.response.patch' | base64 --decode


