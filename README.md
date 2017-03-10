# SMS Campaign

## Environment

You should create an `.env` file with your `MESSAGEBIRD_ACCESS_KEY`.

For exemple:

```
MESSAGEBIRD_ACCESS_KEY=test_mMpKiR0501S86Ph3heX5fACiu
```

## Launch server

```
docker-compose build
docker-compose up
```

## Deployment

```
docker-compose run web rails assets:precompile
heroku container:push --web sms-campaign
```
