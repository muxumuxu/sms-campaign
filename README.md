# SMS Campaign

## Environment

You should create an `.env` file with your `MESSAGEBIRD_ACCESS_KEY`.

For exemple:

```
RAILS_ENV=development
MESSAGEBIRD_ACCESS_KEY=test_mMpKiR0501S86Ph3heX5fACiu
REDISTOGO_URL=redis://redis
POSTMARK_SMTP_SERVER=smtp.postmarkapp.com
POSTMARK_API_KEY=
POSTMARK_INBOUND_ADDRESS=
```

## Launch server

```
docker-compose build
docker-compose up
```

## Deployment

```
./deploy.sh
```
