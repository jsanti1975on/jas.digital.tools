===========( ! Ethical Web Scraper for CompTIA Sec+ Certification study semester Spring 2025 Valencia State College. )===========
==[ Gets the data needs some more fuctions to format to user liking ]==
```python
import requests
from bs4 import BeautifulSoup

# URL of the target article
article_url = "https://library.mosse-institute.com/articles/2022/05/the-attacker-mindset-the-dad-triad/the-attacker-mindset-the-dad-triad.html"

def scrape_article(url):
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
        "Title": title,
        "Content": content,
        "URL": url
    }

# Scrape the article
article_data = scrape_article(article_url)

# Display the results
if article_data:
    print(f"Title: {article_data['Title']}\n")
    print(f"Content:\n{article_data['Content']}\n")
else:
    print("Failed to scrape the article.")

```

