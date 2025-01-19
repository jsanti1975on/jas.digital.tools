# CompTIA Security+ Study Notes: Side-Channel Attacks

In this section, we discuss **side-channel attacks**, which involve exploiting physical properties of cryptographic systems (such as power consumption, electromagnetic emissions, or timing) to compromise the security of sensitive data. This kind of attack targets the hardware and environment where cryptographic operations take place, not just the cryptographic algorithms themselves.

## Side-Channel Attack Overview

The image below provides a typical setup for side-channel attacks. It demonstrates how attackers can analyze physical signals emitted by hardware during cryptographic operations to extract sensitive information, such as encryption keys or other secrets.

![Side-Channel Attack Setup](https://github.com/user-attachments/assets/99eb0a08-b984-4dac-a674-3a46e0568985)

> **Note**: This practical workflow demonstrates how attackers can exploit physical properties (power, EM emissions, or timing) to compromise cryptographic systems. The diagram above highlights the importance of securing not only cryptographic algorithms but also the hardware and environment in which they operate.

## Learn More: YouTube Resource

### For a deeper dive into side-channel attacks, check out the following YouTube video:

- **Side-Channel Attacks**  
  > 45,765 views • Mar 30, 2017  
  > MIT 6.858 Computer Systems Security, Fall 2014  
  > Instructor: Nickolai Zeldovich  

In this lecture, Professor Zeldovich discusses side-channel attacks, specifically **timing attacks**.

[Watch the video](https://youtu.be/3v5Von-oNUg)

## Learn More: YouTube Resource 

- **Radio Hacking: Cars, Hardware, and more! - Samy Kamkar - AppSec California 2016**
> 1,699,881 views  Mar 21, 2016

[Watch the video](https://youtu.be/1RipwqJG50c?list=PLllyXyS8kBLz0Oxtfhg8zQ_bJYH0U3TKo)

## Learn More: YouTube Resource 

- **Side-Channel Attacks on Everyday Applications**
> 28,806 views  Nov 22, 2016

[Watch the video](https://youtu.be/GPwNFrpd1KU)


## Learn More: YouTube Resource

- **Next Name of Video**
> view count and date

[Watch the video](https://<Link to video>/)

## Learn More: YouTube Resource

- **Next Name of Video**
> view count and date

[Watch the video](https://<Link to video>/)

## Learn More: YouTube Resource

- **Next Name of Video**
> view count and date

[Watch the video](https://<Link to video>/)

## Learn More: YouTube Resource

- **Next Name of Video**
> view count and date

[Watch the video](https://<Link to video>/)

## Learn More: YouTube Resource

- **Next Name of Video**
> view count and date

[Watch the video](https://<Link to video>/)

============================================
============Review Format Below============
# CompTIA Security+ Study Notes: Side-Channel Attacks

This section covers **side-channel attacks**, which exploit physical properties (like power consumption, electromagnetic emissions, or timing) of hardware to compromise the security of sensitive data. These attacks target the environment and hardware involved in cryptographic operations, not just the algorithms themselves.

## Side-Channel Attack Overview

Side-channel attacks focus on extracting sensitive information, such as encryption keys, by analyzing physical signals emitted during cryptographic operations. The following image shows a typical setup for such attacks.

![Side-Channel Attack Setup](https://github.com/user-attachments/assets/99eb0a08-b984-4dac-a674-3a46e0568985)

> **Note**: The diagram highlights how attackers exploit physical properties (power, EM emissions, or timing) to compromise cryptographic systems, emphasizing the need to secure both algorithms and hardware.

## Learn More: YouTube Resources

### 1. **Side-Channel Attacks**  
   - MIT 6.858 Computer Systems Security, Fall 2014  
   - Instructor: Nickolai Zeldovich  
   [Watch the video](https://youtu.be/3v5Von-oNUg)  
   *In-depth explanation of side-channel and timing attacks.*

### 2. **Radio Hacking: Cars, Hardware, and more!** - Samy Kamkar - AppSec California 2016  
   [Watch the video](https://youtu.be/1RipwqJG50c?list=PLllyXyS8kBLz0Oxtfhg8zQ_bJYH0U3TKo)

### 3. **Side-Channel Attacks on Everyday Applications**  
   [Watch the video](https://youtu.be/GPwNFrpd1KU)

### 4. **Spectre and Meltdown**  
   [Watch the video](https://youtu.be/mgAN4w7LH2o)  
   *Learn about how Spectre and Meltdown exploit side-channel vulnerabilities in modern processors.*


====================================Project)=========================================\
https://youtu.be/BHqrA8lzz2o?list=PLllyXyS8kBLz0Oxtfhg8zQ_bJYH0U3TKo
-----------------------------------------------------------------------------------(more study)-------

https://youtu.be/GPwNFrpd1KU?list=PLllyXyS8kBLz0Oxtfhg8zQ_bJYH0U3TKo
----------------------------------------------------------------------------(test)-------
```Title: Side-Channel Attacks on Everyday Applications
Description: by Taylor Hornby

In 2013, Yuval Yarom and Katrina Falkner discovered the FLUSH+RELOAD L3 cache side-channel. So far it has broken numerous implementations of cryptography including, notably, the AES and ECDSA in OpenSSL and the RSA GnuPG. Given FLUSH+RELOAD's astounding success at breaking cryptography, we're lead to wonder if it can be applied more broadly, to leak useful information out of regular applications like text editors and web browsers whose main functions are not cryptography.

In this talk, I'll briefly describe how the FLUSH+RELOAD attack works, and how it can be used to build input distinguishing attacks. In particular, I'll demonstrate how when the user Alice browses around the top 100 Wikipedia pages, the user Bob can spy on which of those pages she's visiting.

This isn't an earth-shattering attack, but as the code I'm releasing shows, it can be implemented reliably. My goal is to convince the community that side channels, FLUSH+RELOAD in particular, are useful for more than just breaking cryptography. The code I'm releasing is a starting point for developing better attacks. If you have access to a vulnerable CPU running a suitable OS, you should be able to reproduce the attack within minutes after watching the talk and downloading the code.
Views: 28807
Publish Date: 20161122
```










 
