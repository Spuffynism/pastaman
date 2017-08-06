# pastaman
Pastaman allows you to emulate Facebook messages sent to a webhook callback url, skipping Facebook as the middle-man and saving configuration time.

## Why
I got tired of having to configure my changing [ngrok](https://github.com/inconshreveable/ngrok) [facebook webhook callback url](https://developers.facebook.com/docs/messenger-platform/guides/setup#webhook_setup) every time I started ngrok to publicly expose my local development environment.

## Usage
```
C:\pastaman>pastaman -u <complete_uri> -n <request_name>
C:\pastaman>pastaman -n <hostname> -p <port> -w <webhook_url> -n <request_name>
```
For more examples, see `C:\pastaman>pastaman -h`

## Examples
```
C:\pastaman>pastaman -u localhost:8080/facebook/webhook -r text_message
C:\pastaman>pastaman -u localhost/facebook/webhook -n photo
C:\pastaman>pastaman -n localhost -p 8080 -w /facebook/webhook -n photo
```

## TODO
- Add `photos` and `text_messages` requests to the requests.json file
- Make use of all command line arguments
- Add ability to load default configurations from config file
- Write tests
