import React from "react";
import { render, fireEvent } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";
import Calculator from "./Calculator";
import { test, expect } from "@jest/globals";

test("renders calculator", () => {
  const { getByText } = render(<Calculator />);

  // Check if the calculator renders correctly
  expect(getByText("1")).toBeInTheDocument();
  expect(getByText("2")).toBeInTheDocument();
  expect(getByText("C")).toBeInTheDocument();
  expect(getByText("=")).toBeInTheDocument();
});

test("calculates area of a circle", () => {
  const { getByLabelText, getByText } = render(<Calculator />);

  // Input radius and calculate area
  fireEvent.change(getByLabelText("Circle Radius:"), {
    target: { value: "5" },
  });
  fireEvent.click(getByText("Calculate Circle Area"));
  expect(getByText("Circle Area: 78.54")).toBeInTheDocument();
});

test("calculates area of a triangle", () => {
  const { getByLabelText, getByText } = render(<Calculator />);

  // Input base and height and calculate area
  fireEvent.change(getByLabelText("Triangle Base:"), {
    target: { value: "10" },
  });
  fireEvent.change(getByLabelText("Triangle Height:"), {
    target: { value: "5" },
  });
  fireEvent.click(getByText("Calculate Triangle Area"));
  expect(getByText("Triangle Area: 25.00")).toBeInTheDocument();
});

test("calculates area of a square", () => {
  const { getByLabelText, getByText } = render(<Calculator />);

  // Input side length and calculate area
  fireEvent.change(getByLabelText("Square Side:"), { target: { value: "4" } });
  fireEvent.click(getByText("Calculate Square Area"));
  expect(getByText("Square Area: 16.00")).toBeInTheDocument();
});

test("performs subtraction operation", () => {
  const { getByText, getByRole } = render(<Calculator />);

  // Perform a basic calculation: 5 - 3 = 2
  fireEvent.click(getByText("5"));
  fireEvent.click(getByText("-"));
  fireEvent.click(getByText("3"));
  fireEvent.click(getByText("="));
  expect(getByRole("textbox")).toHaveValue("5-3");
  const resultDiv = getByRole("textbox").nextSibling;
  expect(resultDiv).toHaveTextContent("1");
});

test("performs multiplication operation", () => {
  const { getByText, getByRole } = render(<Calculator />);

  // Perform a basic calculation: 4 * 3 = 12
  fireEvent.click(getByText("4"));
  fireEvent.click(getByText("*"));
  fireEvent.click(getByText("3"));
  fireEvent.click(getByText("="));
  expect(getByRole("textbox")).toHaveValue("4*3");
  const resultDiv = getByRole("textbox").nextSibling;
  expect(resultDiv).toHaveTextContent("12");
});

test("performs division operation", () => {
  const { getByText, getByRole } = render(<Calculator />);

  // Perform a basic calculation: 8 / 2 = 4
  fireEvent.click(getByText("8"));
  fireEvent.click(getByText("/"));
  fireEvent.click(getByText("2"));
  fireEvent.click(getByText("="));
  expect(getByRole("textbox")).toHaveValue("8/2");
  const resultDiv = getByRole("textbox").nextSibling;
  expect(resultDiv).toHaveTextContent("4");
});

test("clear the input", () => {
  const { getByText, getByRole } = render(<Calculator />);

  fireEvent.click(getByText("8"));
  fireEvent.click(getByText("/"));
  fireEvent.click(getByText("2"));
  fireEvent.click(getByText("C"));
  expect(getByRole("textbox")).toHaveValue("");
});
