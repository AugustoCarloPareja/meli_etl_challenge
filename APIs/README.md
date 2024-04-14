# APIs - Mercado Libre Challenge
The `MercadoLibreAPI` class is designed to interact with the MercadoLibre API to retrieve item details based on search terms and save the results to a CSV file for further analysis. This documentation provides an overview of the class methods and how to use them.

## Class: MercadoLibreAPI
### Constructor
```python
def __init__(self, search_terms)
```
**Parameters:**

- `search_terms`: A list of search terms to query the MercadoLibre API.

**Description:** Initializes the `MercadoLibreAPI` object with the provided search terms.

---

### Method: get_item_details
```python
def get_item_details(self, item_id)
```
**Parameters:**

- **item_id:** The unique identifier of the item to retrieve details for.

**Returns:** A JSON object containing details of the specified item.

**Description:** Retrieves the details of a specific item from the MercadoLibre API based on its ID.

---

### Method: get_item_ids
```python
def get_item_ids(self, search_term, limit=50)
```

**Parameters:**

- **search_term:** The search term to query the MercadoLibre API.
- **limit (optional):** The maximum number of items to retrieve. Default is 50.

**Returns:** A list of item IDs matching the specified search term.

**Description:** Queries the MercadoLibre API to retrieve a list of item IDs based on the provided search term.

---

### Method: save_to_csv
```python
def save_to_csv(self)
```

**Description:** Saves the retrieved item details to a CSV file named "product_data.csv" with specified fields.

---

### Method: fetch
```python
def fetch(self)
```

**Description:** Fetches item details for each search term provided in the constructor, saves them to a CSV file, and stores them in the item_details attribute of the MercadoLibreAPI object.


## Usage Example
```python
if __name__ == '__main__':
    # Define search terms
    search_terms = ["chromecast", "google home", "apple tv", "amazon fire tv", "directv go", "xiaomi mi tv"]

    # Initialize MercadoLibreAPI object
    meli_api = MercadoLibreAPI(search_terms)

    # Fetch item details and save to CSV
    meli_api.fetch()
```
This example initializes a MercadoLibreAPI object with a list of search terms, fetches item details for each term, and saves the results to a CSV file named "product_data.csv".

## How to run the python file

If you wanna run the current script with default settings, you can simply use in terminal:
```
python -b meli_fetch.py
```

## Further considerations
This little class can also be built in a Flask app or even in DRF to make a nice REST API to fetch your data (maybe using a data model to "customize" your search).