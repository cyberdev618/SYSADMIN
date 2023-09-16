#####    wget -i images.txt
#Download the signatures for your image of choice keep them in the same directory as this script 
echo Integrity check!
# you only need one of these uncomment the one you wish to use or keep both
echo "checking image  integrity"
sha256sum -c SHA25SUMS 2> /dev/null | grep netinst
sha512sum -c SHA512SUMS 2> /dev/null|grep netinst

gpg --verify SHA512SUMS.sign
gpg --verify SHA256SUMS.sign

echo "Enter the RSA KeyRing ID is your image using"
read $keyringID
echo "getting debian keyring data"
gpg --keyserver keyring.debian.org --recv $keyringID
echo "checking signature integrity"

gpg --verify SHA512SUMS.sign
gpg --verify SHA256SUMS.sign
