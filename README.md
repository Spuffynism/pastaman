# pastaman
Pastaman allows you to emulate Facebook messages sent to a webhook callback url, skipping Facebook as the middle-man and saving configuration time.

## Why
I got tired of having to configure my changing [ngrok](https://github.com/inconshreveable/ngrok) webhook callback url every time I started ngrok to publicly expose my local development environment.

## Usage
`C:\pastaman>messenger.rb <webhook_url> <request_name>`

## Examples
```
C:\pastaman>messenger.rb localhost:8080 text_message
C:\pastaman>messenger.rb localhost:8080 photo
```

## TODO
- Add `photos` and `text_messages` requests to a requests.json file
- Make the webhook url more configurable - all requests are currently sent to `<webhook_url>/facebook/webhook`
- Load default configurations from a config.json file
- Write tests
