## Non-Repudiation in GitHub: The Unbreakable Chain

Imagine you're working on a project, and you write some code. Non-repudiation means that once you commit that code, you can't deny you wrote it, and no one can change it without it being noticed. Here's how GitHub helps you achieve non-repudiation:

**The Steps:**

* **Writing the Code (Authoring)**
    * You write the code, showing your intent to contribute. But on its own, this doesn’t prove anything yet.

* **Committing the Code**
    * You save your changes by creating a commit. Git generates a unique ID (hash) for your code, like a fingerprint. This proves you wrote that specific version of the code, ensuring non-repudiation.

* **Pushing to GitHub**
    * You send your code to GitHub. This adds it to the repository’s history with a timestamp, proving your code's identity and its position in the overall history. This is like “signing” and “timestamping” your work to prevent anyone from denying it later.

* **Verification**
    * Others can check your code to make sure it hasn't been tampered with. They can compare the unique hash to ensure that the code remains unchanged, ensuring non-repudiation.

* **Collaborating with Others**
    * Others can build upon your work by creating their own commits. The commits are all linked, creating a clear, auditable chain of who did what and when, providing full non-repudiation.

**Why Non-Repudiation Matters**

* **Proving Who Did What (Backwards):** If there’s a question about who wrote a specific piece of code, you can trace it back to your original commit. The unique hash provides evidence that you were the author, ensuring non-repudiation.

* **Proving Code Integrity (Forwards):** If someone tries to alter the code, the chain of hashes will break, making it obvious where and when the tampering happened. This ensures the code’s integrity and supports non-repudiation.

**GitHub Tools that Help Support Non-Repudiation:**

* **Version Control:** Git tracks every change, providing an unchangeable history of commits, ensuring non-repudiation.

* **Digital Signatures:** You can add extra security by signing your commits. This proves you are the author and protects against others claiming your work, strengthening non-repudiation.

* **Pull Requests:** These allow others to review and approve your changes before they are added, creating a clear record and supporting non-repudiation.

**Key Takeaways:**

* Non-repudiation means you can’t deny writing the code, and no one can change it without it being noticed.
* GitHub’s version control system creates a secure and verifiable record of who made changes, when, and how.
