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

# **Breaking down the project.**

## **Host 1**: Windows Server 2022 (Active Directory, Domain Controller, Certificate Authority)
- *Certificate Authority* => Configure

# ✅ Windows Server 2022 - Enterprise CA Setup Guide

## 🎯 Purpose of Demonstration
This guide provides step-by-step instructions for setting up an **Enterprise Certificate Authority (CA)** on a **dedicated VM** in a **Windows Server 2022 Active Directory (AD) environment**. This CA will issue **SSL/TLS, authentication, and encryption certificates** for **Windows and Linux (RHEL) machines** within the **orkidz-west.arpa** domain.

## 🛠️ Prerequisites
✔️ Windows Server 2022 VM  
✔️ Joined to **orkidz-west.arpa** domain  
✔️ Administrator privileges  
✔️ Static IP Address  
✔️ Active Directory Certificate Services (AD CS) installation media  
✔️ DNS configured  

---

## 🚀 Step-by-Step Setup

### 📌 1. Prepare the Windows Server 2022 VM
- [ ] **Set a Static IP** (e.g., `192.168.0.X`)
- [ ] **Join the domain** `orkidz-west.arpa`
- [ ] **Rename the server** (e.g., `ca-server.orkidz-west.arpa`)
- [ ] **Enable Remote Desktop** (for easier management)

### 📌 2. Install Active Directory Certificate Services (AD CS)
- [ ] Open **Server Manager** → **Manage** → **Add Roles and Features**
- [ ] Select **Active Directory Certificate Services (AD CS)**
- [ ] Choose **Enterprise CA**
- [ ] Select **Certification Authority (CA)** role

### 📌 3. Configure the CA Role
- [ ] **Choose Enterprise CA**
- [ ] **Set as Root CA**
- [ ] **Create a new private key**
- [ ] **Set Cryptographic Options** (2048-bit key, SHA256)
- [ ] **Set CA Name** (e.g., `Orkidz-RootCA`)
- [ ] **Define Validity Period** (e.g., 5 or 10 years)
- [ ] **Confirm and Install**

### 📌 4. Configure Certificate Templates and Auto-Enrollment
- [ ] Open **Certification Authority MMC** (`certsrv.msc`)
- [ ] Enable **Auto-Enrollment** via Group Policy (`gpedit.msc`)
- [ ] Duplicate **Computer Certificate Template** for issuing to Linux & Windows machines
- [ ] Allow **Domain Computers & Domain Users** to enroll

### 📌 5. Issue Certificates for Windows and Linux Authentication
#### 🖥️ Windows Clients:
- [ ] Run `certmgr.msc` and request a certificate from AD CA

#### 🖥️ Linux (RHEL) Clients:
- [ ] Export **Root CA Certificate** (`.cer` file) from `ca-server`
- [ ] Copy the certificate to Linux machine (`scp` or USB)
- [ ] Install CA Certificate:
  
```bash
  sudo cp Orkidz-RootCA.cer /etc/pki/ca-trust/source/anchors/
  sudo update-ca-trust extract
```

#### 📌 6. Test Certificate Deployment
- [ ] Use `openssl` to verify **CA** trust on Linux
- [ ] use `openssl s_client -connect dc-terete.orkidz-west.arpa:636 -CAfile /etc/pki/ca-trust/source/anchors/Orkidz-RootCA.cer`
- [ ] Validate certificate presence on Windows via `certlm.msc`

## 🎯 Demonstration & Use Cases
- ✅ Windows Authentication with Certificates
- ✅ Linux Machine Authentication using CA
- ✅ SSL/TLS for Web Apps and Services
- ✅ Securing LDAP & Remote Desktop with Certificates

## 📌 Next Steps
- 🔹 Configure Online Certificate Status Protocol (OCSP)
- 🔹 Implement Certificate Revocation List (CRL)
- 🔹 Integrate with RADIUS for 802.1X authentication

