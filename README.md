# README

Unofficial Rails [Internshala](https://internshala.com) API

## To run

Prerequisites: [Redis](https://redis.io/)

After installing Redis, run:
```
bundle install
```
Then, after setting up the DB, run:
```
sidekiq
```

## Routes

1. `\api\v1\offer?count=number` - Get last `number` number of internships scraped from the website.
2. `\api\v1\tag` - Get a list of all the tags scraped from the website
3. `\api\v1\offers` - Get list of offers pertaining to specific parameters
    - `tags` : list of comma separated tags to filter the internship offers
    - `max_pay` : filter offers based on maximum stipend in offers
    - `min_pay` : filter offers based on minimum stipend in offers
4. `api\v1\offer\id` - Get individual offer data based on its `id`
5. `api\v1\tag\id` - Get individual tag data based on its `id`


