# SMS Campaign

## Environment

You should create an `.env` file filled with information below.

```
RAILS_ENV=development
REDISTOGO_URL=redis://redis
REDIS_PROVIDER=REDISTOGO_URL
POSTMARK_SMTP_SERVER=smtp.postmarkapp.com
POSTMARK_API_KEY=1cad7987-4a84-4da7-9352-fa2ef45172d6
POSTMARK_INBOUND_ADDRESS=758d5d12ca6b91de3bc179daea013cec@inbound.postmarkapp.com
TWILIO_ACCOUNT_SID=ACd2d193f32418f51e4b1b860a972c2e30
TWILIO_AUTH_TOKEN=ce1bfb4cf7b176a92f1ec2badd6148e9
TWILIO_NUMBER=+33644644521
ROLLBAR_ACCESS_TOKEN=fd8e5a42291743afa8a3a9e47319e8f7
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
