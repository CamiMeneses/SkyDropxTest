# README

This is a website to track shipments and know their status using the fedex gem

![alt text](https://github.com/CamiMeneses/SkyDropxTest/blob/master/readme_files/index.png?raw=true)

To search a new shipment, push the bottom '+' and add a new register or put a JSON like this:
```
[
    {
        "tracking_number": "449044304137821",
        "carrier": "FEDEX"
    },
    {
        "tracking_number": "920241085725456",
        "carrier": "FEDEX"
    },
    {
        "tracking_number": "568838414941",
        "carrier": "FEDEX"
    }
]
```

![alt text](https://github.com/CamiMeneses/SkyDropxTest/blob/master/readme_files/new.png?raw=true)

## How to see this website:

1. Clone this repository

2. Run the server: rails server

3. Open your localhost:3000 in your browser

## To run tests:
rspec

