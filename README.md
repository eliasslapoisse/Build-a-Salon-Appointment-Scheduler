# Salon Appointment Scheduler

A command-line appointment scheduler for a salon. The application is a Bash script backed by PostgreSQL: customers select a service, provide a phone number, and choose an appointment time. Returning customers are looked up by phone number; new customers are added automatically.

## Requirements

- Bash
- PostgreSQL and the `psql` command-line client
- A PostgreSQL role named `freecodecamp`

## Setup

1. Make sure the `freecodecamp` PostgreSQL role exists and can create databases. For a local PostgreSQL installation, you can create it with:

	```sql
	CREATE ROLE freecodecamp WITH LOGIN CREATEDB;
	```

2. Load the schema and sample data:

	```bash
	psql -U postgres < salon.sql
	```

	The SQL dump drops and recreates the `salon` database, so do not run this command if you need to preserve existing salon data.

3. Make the scheduler executable if necessary:

	```bash
	chmod +x salon.sh
	```

## Run

Start the scheduler with:

```bash
./salon.sh
```

Follow the prompts to:

1. Choose a service by its numeric ID.
2. Enter a phone number.
3. Provide a name if the phone number is new.
4. Enter the appointment time.

The script currently seeds these services:

| ID | Service |
| ---: | --- |
| 1 | Haircut |
| 2 | Haircolor |
| 3 | Hairstyling |

## Database schema

The `salon` database contains three related tables:

- `services`: available services and their IDs.
- `customers`: unique customer names and phone numbers.
- `appointments`: appointment times linked to a customer and service.

Foreign keys maintain the customer and service relationships. Appointment times are stored as text, so values such as `10:30`, `11am`, or `1pm` are accepted.

## Files

- `salon.sh` - interactive Bash application.
- `salon.sql` - PostgreSQL schema, constraints, and sample data dump.
- `examples.txt` - example successful interactions with the scheduler.
