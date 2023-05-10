# NFS Client using IBM JDK

using IBM JDK based `ibmjava:8-sdk` as image. This is for supporting that other java appplication using FIPS mode can run.

### activate IBMJCEFIPS

`$JAVA_HOME` refers to location of java jre inside the java container image that being used to host the jar application


if meeting this error when running springboot jar application : 
 > "no such provider: IBMJCEFIPS" 

 - Check if this file exists: `$JAVA_HOME/jre/lib/ext/ibmjcefips.jar`
 - Look in `$JAVA_HOME/jre/lib/security/java.security` file to make sure you have the FIPS provider listed .   
   `security.provider.10=com.ibm.crypto.fips.provider.IBMJCEFIPS`

or just copy java.security from remote server

`cp java.security_fromserver /opt/ibm/java/jre/lib/security/java.security`

### ref

https://www.ibm.com/support/pages/error-no-such-provider-ibmjcefips-errorcode0xee0f-tklm