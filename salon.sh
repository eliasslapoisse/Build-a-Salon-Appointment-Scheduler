#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~ MY SALON ~~~~\n\nWelcome to My Salon, how can I help you?\n"

MAIN_FUNC() {
  echo "$($PSQL "SELECT * FROM services;")" | sed "s/|/) /"

  read SERVICE_ID_SELECTED
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
  
  if [[ -z $SERVICE_ID ]]
  then
    echo -e "\nI could not find that service. What would you like today?\n"
    MAIN_FUNC
  else
    echo -e "\nWhat's your phone number?"

    read CUSTOMER_PHONE
    PHONE_NUMBER_IN=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE';")

    if [[ -z $PHONE_NUMBER_IN ]]
    then
      echo -e "\nI don't have a record for that phone number. What's your name?"

      read CUSTOMER_NAME
      INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
    else
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
    fi

    echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
    read SERVICE_TIME

    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID, '$SERVICE_TIME');")

    echo -e "\nI have put you down for a $($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID;") at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_FUNC