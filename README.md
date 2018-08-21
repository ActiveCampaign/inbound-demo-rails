# Postmark Inbound Processing Demo (Rails)

This project contains a demo Rails app that shows how to implement inbound email processing using [Postmark’s inbound webhooks](https://postmarkapp.com/why/inbound).

You will need to have a [Postmark account](https://postmarkapp.com) to run this demo. If you don’t have one already, [sign up for a free account](https://account.postmarkapp.com/sign_up).

## Getting Started

_This tutorial assumes you have Ruby 2.4.1 installed. If not, please [install it using RVM](https://rvm.io)._

1. Clone this repository to your local machine.

```bash
git clone git@github.com:wildbit/inbound-demo-rails.git
```

2. Install the project dependencies using bundler.

```bash
bundle install
```

3. Create the SQLite database.

```bash
rails db:create
```

4. Run the database migrations.

```bash
rails db:migrate
```

5. Seed the database with some example articles.

```bash
rails db:seed
```

6. Open the `/config/initializers/postmark.rb` file and add the hash from the Postmark inbound address that emails will be sent to.

```rb
Rails.application.config.postmark_inbound_email_hash = 'YOUR_POSTMARK_INBOUND_EMAIL_ADDRESS_HASH'
```

_You can find the inbound email address for a Postmark server on the server’s credentials page. The hash is the alphanumeric string that comes before the @ sign. (**c0b622f2dkgj73be69c59033275ef521**@inbound.postmarkapp.com)_

7. Navigate to your Postmark server’s inbound settings page (Settings → Inbound) and set the Webhook field to match your Ultrahook endpoint. (See below for instructions on how to set up Ultrahook.)

8. Start Ultrahook.

```bash
ultrahook inbound-demo 3000
```

9. Start the Rails server.

```bash
rails s
```

10. Navigate to <http://0.0.0.0:3000/articles/1>

11. Click the "Send a response" button at the bottom of the page to launch your email client.

12. Compose a simple message and hit send.

13. After a few seconds, refresh the page. You should see the content of your email appear in the _Responses_ section at the bottom of the page.


## Testing Inbound Webhooks Locally with Ultrahook
In order to test inbound webhooks while running the app locally, you can use a service called [Ultrahook](http://www.ultrahook.com). Once set up, Ultrahook receives incoming webhooks from Postmark and forwards them to the instance of the app you have running locally on your machine.

The ultrahook ruby gem is included in this project’s `Gemfile`. Should you need to install it separately, run: `gem install ultrahook`. 

1. Sign up for an account at [ultrahook.com](http://www.ultrahook.com)
2. Add your Ultrahook API key to a file in your home folder:
```bash
echo "api_key: YOUR_ULTRAHOOK_API_KEY" > ~/.ultrahook
```
3. Start Ultrahook, ensure the port supplied here matches the port your Rails app is running on (usually 3000).
```bash
ultrahook inbound-demo 3000
```
4. You should now see that Ultrahook has started running. The external URL you can use to forward requests to your local machine will be printed in your console.
```bash
Authenticated as YOUR_USER
Forwarding activated...
http://inbound-demo.YOUR_USER.ultrahook.com -> http://localhost:3000
```
5. Log in to your [Postmark](https://account.postmarkapp.com) account.
6. Select a server that will handle your inbound emails and navigate to the inbound settings page (Settings → Inbound).
7. Set the webhook field using the Ultrahook URL that was output in your console and hit save. Don’t forget to add the `/responses` path to the end of the URL. This is the endpoint in the Rails app that will handle inbound emails.
```
http://inbound-demo.YOUR_USER.ultrahook.com/responses
```

Ultrahook will now forward any inbound webhooks from Postmark to your local machine.

## Questions?

If you need help with anything in this demo, please [create a ticket in the issue tracker](https://github.com/wildbit/inbound-demo-rails/issues/new).
