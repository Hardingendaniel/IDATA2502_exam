#!/bin/sh
# run_tests.sh

# Wait for the deployed application to be ready
sleep 180  # Increase wait time if necessary

# Check if the application pod is running
kubectl wait --for=condition=ready pod -l app=react-app --timeout=300s

# Health check: Verify the application is up and running
curl -f http://localhost:3000 || exit 1

# Run Cypress tests
npx cypress run --spec "cypress/integration/app_spec.js"

