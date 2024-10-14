#Generate RSA Key Pair
resource tls_private_key pvtkey{
 algorithm = "RSA"
 rsa_bits  = 4096
}

#Store Above generated Private key in file
resource local_file key_details{
 filename = "/root/key.txt"
 content  = "${tls_private_key.pvtkey.private_key_pem}"
}
