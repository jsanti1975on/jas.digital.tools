===========( ! Ethical Web Scraper for CompTIA Sec+ Certification study semester Spring 2025 Valencia State College. )===========
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

    soup = BeautifulSoup(response.text, 'html.parser')

    # Update this selector based on the website's structure
    title = soup.find('h1').get_text(strip=True) if soup.find('h1') else "Unknown Title"
    
    # Experiment with broader selectors if <article> is missing
    article_body = soup.find(class_='content') or soup.find('main') or soup.find('body')
    if not article_body:
        print("Article content not found. Please inspect the website's structure.")
        return None

    paragraphs = article_body.find_all('p')
    content = "\n".join(p.get_text(strip=True) for p in paragraphs if p.get_text(strip=True))

    return {
        "Title": title,
        "Content": content,
        "URL": url
    }

# Run the scraper
article_data = scrape_article(article_url)

if article_data:
    print(f"Title: {article_data['Title']}")
    print("\nArticle Content:\n")
    print(article_data['Content'])
else:
    print("Failed to scrape the article.")
```

