oc apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cert-user-valid
  namespace: default
spec:
  isCA: true
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: rhcs-issuer-user
  privateKey:
    algorithm: ECDSA
    size: 256
  secretName: cert-user-valid
  commonName: cert1
  subject:
    organizations:
      - mpaas
    organizationalUnits:
      - serviceaccounts
EOF

oc apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cert-user-invalid-o
  namespace: default
spec:
  isCA: true
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: rhcs-issuer-user
  privateKey:
    algorithm: ECDSA
    size: 256
  secretName: cert-user-invalid-o
  commonName: cert1
  subject:
    organizations:
      - other-org
    organizationalUnits:
      - serviceaccounts
EOF


oc apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cert-user-invalid-ou
  namespace: default
spec:
  isCA: true
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: rhcs-issuer-user
  privateKey:
    algorithm: ECDSA
    size: 256
  secretName: cert-user-invalid-ou
  commonName: cert1
  subject:
    organizations:
      - mpaas
    organizationalUnits:
      - users
EOF

oc apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cert-user-invalid-o-ou
  namespace: default
spec:
  isCA: true
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: rhcs-issuer-user
  privateKey:
    algorithm: ECDSA
    size: 256
  secretName: cert-user-invalid-o-ou
  commonName: cert1
  subject:
    organizations:
      - other-org
    organizationalUnits:
      - users
EOF