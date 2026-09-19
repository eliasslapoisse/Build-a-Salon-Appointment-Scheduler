#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~ MY SALON ~~~~\nWelcome to My Salon, how can I help you?\n"

MAIN_FUNC() {
  echo "$($PSQL "SELECT * FROM services;")" | sed "s/|/) /"

  read SERVICE
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE;")
  
  if [[ -z $SERVICE_ID ]]
  then
    echo -e "\nI could not find that service. What would you like today?\n"
    MAIN_FUNC
  fi
}

MAIN_FUNC