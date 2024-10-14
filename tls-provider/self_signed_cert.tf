#RSA Private Key generation
resource tls_private_key pvtKey{
 algorithm = "RSA"
 rsa_bits  = 4096
}

#Use Private Key & generate Self Signed Cert
resource tls_self_signed_cert self_cert{
  private_key_pem  = tls_private_key.pvtKey.private_key_pem
  subject {
   common_name  = "digital_works.com"
   organization = "Digital Works"
  }
  validity_period_hours = 12
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
