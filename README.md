# Overfriendly

## How to Authenticate with the API

The routes under `/api` require `Content-type: application/json` as a header as well as `HTTP_AUTHORIZATION`. You must have signed into the app via Battle.net and an admin must grant you API access via User#grant_api_access. You need the `api_token` value from your record in the users table. Then the authorization header takes the format: `Token YOUR_BATTLETAG YOUR_API_TOKEN`,
e.g., `Token cheshire#1234 nafjk3n2dkslmio`.

## How to Develop

[Create a Battle.net API app](https://dev.battle.net), `cp dotenv.sample .env`, and
copy your Battle.net app key and secret into the .env file as `BNET_APP_ID`
and `BNET_APP_SECRET`.

You will also need to use a service like [ngrok](https://ngrok.com/) to have a public URL
that will hit your local server. Start ngrok via `ngrok http 3000`;
look at the https URL it spits out. In your Battle.net app, set
`https://your-ngrok-id-here.ngrok.io/users/auth/bnet/callback` as
the "Register Callback URL" value. Set `https://your-ngrok-id-here.ngrok.io`
as "Web Site". Update .env so that `BNET_APP_HOST` is set to your `your-ngrok-id-here.ngrok.io`.

Start the Rails server via `bundle exec rails s`. Now you should be able to go to
`https://your-ngrok-id-here.ngrok.io/` and sign in via Battle.net.

## How to Deploy to Heroku

Create an [app on Heroku](https://dashboard.heroku.com/new-app).

Create a [Battle.net app](https://dev.battle.net) and set its "Register Callback URL" to
`https://your-heroku-app.herokuapp.com/users/auth/bnet/callback`. Set
`https://your-heroku-app.herokuapp.com` as the "Web Site".

```bash
heroku git:remote -a your-heroku-app
heroku config:set BNET_APP_ID=your_app_id_here
heroku config:set BNET_APP_SECRET=your_app_secret_here
heroku config:set BNET_APP_HOST=your-heroku-app.herokuapp.com
git push heroku master
heroku run rake db:migrate
heroku open
```
