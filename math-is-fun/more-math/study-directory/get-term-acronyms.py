def format_scraped_data_as_markdown(title, url, content):
    """
    Format the scraped data into Markdown format.
    """
    markdown_output = []

    # Add Title
    markdown_output.append(f"# {title}\n")

    # Add Source URL
    markdown_output.append(f"> Source: [{url}]({url})\n")

    # Add Content
    for line in content.splitlines():
        line = line.strip()
        if line:  # Skip empty lines
            if line.isupper():  # Treat all-uppercase words as headings
                markdown_output.append(f"## {line}")
            else:
                markdown_output.append(line)

    # Join all Markdown components
    return "\n\n".join(markdown_output)


# Example Scraped Data
scraped_data = {
    "title": "IT Terminology – A Glossary of Tech Terms for Beginners",
    "url": "https://www.comptia.org/content/guide/information-technology-terminology#section3",
    "content": """If you’re new to IT and still learning, it might be daunting to read through articles without knowing what any of the words mean. Here we have compiled a list of IT terms that you should add to your flashcards.

A
B
C
D
E
4G, 5G, LTE
4G, 5G and LTE are cellphone network speeds.

Agile
Agile is a project management term that means to continually improve through small and digestible increments.

Algorithm
An algorithm is a sequence of instructions used to perform a task in software.

Artificial Intelligence (AI)
Artificial intelligence (AI) is a term used to describe computers’ aptitude to mimic human abilities such as reasoning, knowledge representation, planning, learning, and perception.

Assembly Language
Assembly language is a low-level programming language that communicates with the hardware of a computer.
"""
}

# Generate Markdown
markdown = format_scraped_data_as_markdown(
    scraped_data["title"], scraped_data["url"], scraped_data["content"]
)

# Save to a Markdown file
with open("it_glossary.md", "w", encoding="utf-8") as file:
    file.write(markdown)

print("Markdown file created successfully!")
