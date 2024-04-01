#/bin/zsh

java -jar ObfuscationService.jar generate
java -jar ObfuscationService.jar obfuscate obfuscation.txt obfuscation.dat

#rm -rf strings.dat
#
#cat D001.dat >> strings.dat
#echo "_END_" >> strings.dat
#cat obfuscation.dat >> strings.dat
#echo "_END_" >> strings.dat
