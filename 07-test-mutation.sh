oc apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cert-user-invalid-algorithm
  namespace: default
spec:
  isCA: true
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: rhcs-issuer-user
  privateKey:
    algorithm: RSA
    size: 2048
  secretName: cert-user-invalid-algorithm
  commonName: cert1
  subject:
    organizations:
      - mpaas
    organizationalUnits:
      - serviceaccounts
EOF