#!/bin/sh
# run_tests.sh

# Wait for the deployed application to be ready
sleep 180  # Ensure enough time for deployment

# Check if the application pod is running
kubectl wait --for=condition=ready pod -l app=react-app --timeout=300s
if [ $? -ne 0 ]; then
  echo "Application pod is not ready. Exiting..."
  exit 1
fi

# Health check: Verify the application is up and running
echo "Performing health check..."
curl -f http://localhost:3000 || exit 1

# Functional check: Verify main page content
echo "Checking main page content..."
curl -s http://localhost:3000 | grep -q "Welcome to the portfolio assignment"
if [ $? -ne 0 ]; then
  echo "Expected content not found on the main page. Exiting..."
  exit 1
fi

echo "All checks passed!"

