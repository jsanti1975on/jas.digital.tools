# Directory Services & Security - Flashcards

## Flashcard 1  
**Q:** What is the purpose of a directory service?  
**A:** A directory service stores information about users, computers, security groups/roles, and services, allowing for authentication and authorization in a networked environment.  

---

## Flashcard 2  
**Q:** What protocol do most directory services use for interoperability?  
**A:** Most directory services use the Lightweight Directory Access Protocol (LDAP), which is based on the X.500 standard.  

---

## Flashcard 3  
**Q:** What is a distinguished name (DN) in an X.500-like directory?  
**A:** A DN is a collection of attribute-value pairs that define a unique identifier for a resource in a directory.  

---

## Flashcard 4  
**Q:** What are common attributes used in a distinguished name (DN)?  
**A:**  
- **CN** (Common Name)  
- **OU** (Organizational Unit)  
- **O** (Organization)  
- **C** (Country)  
- **DC** (Domain Component)  

> Example:  
> CN=WIDGETWEB, OU=Marketing, O=Widget, C=UK, DC=widget, DC=foo

## Flashcard 5  
**Q:** What network port does LDAP use by default?  
**A:** 389 

--

## Flashcard 6  
**Q:** Why is LDAP insecure by default?  
**A:** LDAP transmissions are plaintext, making them vulnerable to sniffing and on-path attacks.  

---

## Flashcard 7  
**Q:** What are the authentication methods available in LDAP?  
**A:**  
- No Authentication (Anonymous Access)  
- Simple Bind (DN and password sent in plaintext)  
- SASL (Uses Kerberos or other mechanisms)  
- LDAPS (Uses TLS encryption, port 636)  

---

## Flashcard 8  
**Q:** What is the recommended secure authentication method for LDAP?  
**A:** LDAPS (LDAP Secure) using **port 636** with TLS encryption.  

---

## Flashcard 9  
**Q:** What command in LDAP can enforce encryption and message integrity?  
**A:** STARTTLS  

---

## Flashcard 10  
**Q:** What security measures should be taken for an LDAP directory server?  
**A:**  
- Disable anonymous and simple authentication.  
- Implement access control policies for read-only and read/write access.  
- Block LDAP port **389** from public access using a firewall.  
- Allow LDAP access only from authorized IPs for internet-integrated services.


