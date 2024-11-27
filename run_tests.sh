#!/bin/sh
# run_tests.sh

# Wait for the deployed application to be ready
sleep 10

# Run Cypress tests npx cypress run
npx cypress run

