# pastaman
Pastaman emulates Facebook messages sent to a webhook callback url, thus skipping Facebook as the middle-man and saving configuration time.

## Why
I got tired of having to configure my changing [ngrok](https://github.com/inconshreveable/ngrok) [facebook webhook callback url](https://developers.facebook.com/docs/messenger-platform/guides/setup#webhook_setup) every time I started ngrok to publicly expose my local development environment.

## Usage
```sh
$ ruby pastaman.rb -u <complete_uri> -n <request_name>
$ ruby pastaman.rb -n <hostname> -p <port> -w <webhook_url> -n <request_name>
```
### Examples
```sh
$ ruby pastaman.rb -u localhost:8080/facebook/webhook -r text_message
$ ruby pastaman.rb -u localhost/facebook/webhook -n photo
$ ruby pastaman.rb -n localhost -p 8080 -w /facebook/webhook -n photo
```
To see all available flags, see `$ ruby pastaman.rb -h`

## Running tests
```sh
$ ruby test/all_test.rb
$ ruby test/${file_name}_test.rb
```
## TODO
- Make use of all command line arguments
- Add ability to load default configurations from config file
- Complete tests