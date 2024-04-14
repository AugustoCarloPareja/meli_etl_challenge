import requests
import csv
import logging

class MercadoLibreAPI:
    def __init__(self, search_terms):
        self.search_terms = search_terms
        self.item_details = []
        
        logging.basicConfig(filename='mercadolibre_api_errors.log', level=logging.ERROR, format='%(asctime)s - %(levelname)s - %(message)s')

    def get_item_details(self, item_id):
        try:
            url = f"https://api.mercadolibre.com/items/{item_id}"
            response = requests.get(url)
            response.raise_for_status()
            return response.json()
        except Exception as e:
            logging.error(f"Error getting item details for {item_id}: {e}")
            return None

    def get_item_ids(self, search_term, limit=50):
        try:
            url = f"https://api.mercadolibre.com/sites/MLA/search?q={search_term}&limit={limit}"
            response = requests.get(url)
            response.raise_for_status()
            data = response.json()
            return [item['id'] for item in data['results']]
        except Exception as e:
            logging.error(f"Error getting item IDs for search term '{search_term}': {e}")
            return []

    def save_to_csv(self):
        with open("product_data.csv", "w", newline="") as csvfile:
            fieldnames = [
                "id", "title", "base_price", "price", "currency_id", "initial_quantity",
                "status", "condition", "permalink", "thumbnail_id", "shipping.free_shipping",
                "date_created", "last_updated"
            ]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()

            for item_details in self.item_details:
                if item_details:
                    row = {
                        "id": item_details["id"],
                        "title": item_details["title"],
                        "base_price": item_details["base_price"],
                        "price": item_details["price"],
                        "currency_id": item_details["currency_id"],
                        "initial_quantity": item_details["initial_quantity"],
                        "status": item_details["status"],
                        "condition": item_details["condition"],
                        "permalink": item_details["permalink"],
                        "thumbnail_id": item_details["thumbnail"],
                        "shipping.free_shipping": item_details["shipping"]["free_shipping"],
                        "date_created": item_details["date_created"],
                        "last_updated": item_details["last_updated"]
                    }
                    writer.writerow(row)

    def fetch(self):
        for search_term in self.search_terms:
            item_ids = self.get_item_ids(search_term)
            for item_id in item_ids:
                item_details = self.get_item_details(item_id)
                self.item_details.append(item_details)

        self.save_to_csv()

if __name__ == '__main__':
    search_terms = ["chromecast", "google home", "apple tv", "amazon fire tv", "directv go", "xiaomi mi tv"]

    meli_api = MercadoLibreAPI(search_terms)
    meli_api.fetch()