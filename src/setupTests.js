import React from 'react';
import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import App from './App';

test('renders the app without crashing', () => {
  render(<App />);
  expect(screen.getByText(/Welcome to the portfolio assignment/i)).toBeInTheDocument();
  expect(screen.getByText(/This is a simple React setup to use delivery pipeline for the portfolio assignment in IDATA2502/i)).toBeInTheDocument();
  expect(screen.getByText(/by Daniel Eikås/i)).toBeInTheDocument();
});
