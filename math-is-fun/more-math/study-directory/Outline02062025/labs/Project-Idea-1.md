# Identity and Access Management Lab Setup (Week 5)

## **Objective**
Set up an authentication system that integrates Windows Active Directory (AD) with Red Hat Linux machines hosted on ESXi. Demonstrate identity and access management (IAM) principles using domain authentication, role-based access control (RBAC), and multi-factor authentication (MFA).

## **Lab Infrastructure**
### **ESXi Hosts**
- **Host 1**: Windows Server 2022 (Active Directory, Domain Controller, Certificate Authority)
- **Host 2**: Red Hat Enterprise Linux (RHEL) machines for domain authentication
- **Host 3**: Additional VMs for testing IAM configurations
- **Host 4**: Backup and monitoring services

### **Networking Components**
- **3 Cisco Switches**
- **2 Cisco Routers**
- VLANs configured for segmentation of authentication traffic

## **Lab Configuration Checklist**
### **1. Windows Domain Setup**
- [ ] Install and configure **Windows Server 2022** as a Domain Controller (DC)
- [ ] Set up **Active Directory (AD)**
- [ ] Configure **Group Policy (GPO)** for user access control
- [ ] Implement **Role-Based Access Control (RBAC)** using AD security groups
- [ ] Configure **Certificate Authority (CA)** for authentication and encryption

### **2. Red Hat Linux Integration with AD**
- [ ] Join **RHEL machines to Active Directory** using `realmd`, `sssd`, or `winbind`
- [ ] Configure **Kerberos authentication** for AD integration
- [ ] Set up **LDAP authentication** with AD as the identity provider
- [ ] Configure **sudo rules** for RBAC based on AD security groups

### **3. Authentication & Access Management**
- [ ] Implement **Single Sign-On (SSO)** for Windows and Linux systems
- [ ] Enforce **Multi-Factor Authentication (MFA)** for Windows and Linux users
- [ ] Test **LDAP and Kerberos authentication** on Linux machines
- [ ] Validate **user logins and permissions** across domains

### **4. Security Hardening & Monitoring**
- [ ] Enable **audit logs** for authentication events
- [ ] Configure **fail2ban** or similar tool for Linux login protection
- [ ] Set up **Windows Event Viewer** for monitoring authentication attempts
- [ ] Implement **SIEM solution (Splunk/ELK)** for centralized logging

### **5. Testing & Validation**
- [ ] Test **Windows domain authentication** from Linux machines
- [ ] Verify **GPO policies apply** to domain-joined Linux machines
- [ ] Check **access control restrictions** for different user roles
- [ ] Perform **penetration testing** to evaluate authentication security
- [ ] Document **findings and best practices** for IAM security

## **Optional Enhancements**
- [ ] Deploy **FreeIPA** for centralized Linux authentication
- [ ] Implement **Azure AD Sync** for hybrid authentication
- [ ] Integrate **SSH key-based authentication** for secure access

## **Deliverables**
- **Network topology diagram** (Visio, Draw.io, or Lucidchart)
- **Configuration documentation** for AD and Linux authentication
- **Access control policy report** detailing IAM implementation
- **Security assessment findings** on authentication setup

---
This checklist aligns with **Week 5: Identity and Access Management Study** in Informtion Security 
