===========( ! Ethical Web Scraper for CompTIA Sec+ Certification study semester Spring 2025 Valencia State College. )===========
==[ Gets the data needs some more fuctions to format to user liking ]==
```python
#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup

class MarkdownFormatter:
    @staticmethod
    def format(title, url, content):
        """
        Format scraped data into Markdown format, omitting unnecessary headers.
        """
        markdown_output = []
        markdown_output.append(f"# {title}\n")
        markdown_output.append(f"> Source: [{url}]({url})\n")

        skip_headers = set(  # Headers to omit
            "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split()
        )

        for line in content.splitlines():
            line = line.strip()
            if line:
                if line.isupper() and line in skip_headers:  # Skip unnecessary headers
                    continue
                if line.isupper():  # Treat other uppercase lines as headings
                    markdown_output.append(f"## {line}")
                else:
                    markdown_output.append(line)

        return "\n\n".join(markdown_output)


def scrape_article(url):
    """
    Scrape the article from the given URL.
    """
    try:
        response = requests.get(url)
        response.raise_for_status()
    except requests.RequestException as e:
        print(f"Error fetching the URL: {e}")
        return None

    # Parse the HTML
    soup = BeautifulSoup(response.text, 'html.parser')

    # Extract the title
    title_section = soup.find('section', class_='titleSection')
    title = title_section.find('h1').get_text(strip=True) if title_section else "Unknown Title"

    # Extract the main content
    content_div = soup.find('div', class_='col-md-9 main-content')
    if content_div:
        # Extract paragraphs
        paragraphs = content_div.find_all(['p', 'li'])
        content = "\n".join(p.get_text(strip=True) for p in paragraphs if p.get_text(strip=True))
    else:
        content = "Content not found."

    return {
        "title": title,
        "content": content,
        "url": url
    }


if __name__ == "__main__":
    # URL to scrape
    article_url = 'https://www.comptia.org/content/guide/information-technology-terminology#section3'

    # Scrape the article
    article_data = scrape_article(article_url)

    if article_data:
        # Format the scraped data into Markdown
        markdown = MarkdownFormatter.format(
            article_data["title"], article_data["url"], article_data["content"]
        )

        # Save the Markdown to a file
        output_file = "it_glossary.md"
        with open(output_file, "w", encoding="utf-8") as file:
            file.write(markdown)

        print(f"Markdown file created successfully: {output_file}")
    else:
        print("Failed to scrape the article.")


```

