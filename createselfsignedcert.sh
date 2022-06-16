#   There are quite a few fields but you can leave some blank
#   For some fields there will be a default value,
#   If you enter '.', the field will be left blank.
#   -----
#   Country Name (2 letter code) [AU]: US
#   State or Province Name (full name) [Some-State]: Your full name state
#   Locality Name (eg, city) []: Your full name city
#   Organization Name (eg, company) [Internet Widgits Pty Ltd]: Your Company
#   Organizational Unit Name (eg, section) []:Dev
#   Common Name (e.g. server FQDN or YOUR name) []:localhost
#   Email Address []:dev@yourcompany.com
#   Generating a 2048 bit RSA private key
#   .......+++
#   ..............................................................................+++
#   writing new private key to 'server.key'
#   -----
#   Signature ok
#   subject=/C=US/ST=Utah/L=South Jordan/O=End Point/OU=Local Domain/emailAddress=dev@yourcompany.com/CN=localhost
#   Getting CA Private Key
#   Enter pass phrase for ca.key:
#
# Add ca.crt to your keychain
# Enjoy
#
# Add CA
openssl genrsa -des3 -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1024 -out ca.crt
# Generate SSC
openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config <( cat server.csr.cnf )
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile v3.ext