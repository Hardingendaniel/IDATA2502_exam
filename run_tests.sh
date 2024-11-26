#!/bin/sh
# run_tests.sh

# Wait for the deployed application to be ready
sleep 180

kubectl wait --for=condition=ready pod -l app=my-app --timeout

# Health check: Verify the application is up and running
curl -f http://localhost:3000 || exit 1


