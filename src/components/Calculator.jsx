import React, { useState } from "react";
import "./Calculator.css";

const Calculator = () => {
  const [input, setInput] = useState("");
  const [result, setResult] = useState("");
  const [circleRadius, setCircleRadius] = useState("");
  const [triangleBase, setTriangleBase] = useState("");
  const [triangleHeight, setTriangleHeight] = useState("");
  const [squareSide, setSquareSide] = useState("");
  const [areaResult, setAreaResult] = useState("");

  const handleClick = (value) => {
    setInput(input + value);
  };

  const handleClear = () => {
    setInput("");
    setResult("");
    setAreaResult("");
  };

  const handleCalculate = () => {
    try {
      setResult(eval(input));
    } catch (error) {
      setResult("Error");
    }
  };

  const calculateCircleArea = () => {
    const area = Math.PI * Math.pow(circleRadius, 2);
    setAreaResult(`Circle Area: ${area.toFixed(2)}`);
  };

  const calculateTriangleArea = () => {
    const area = 0.5 * triangleBase * triangleHeight;
    setAreaResult(`Triangle Area: ${area.toFixed(2)}`);
  };

  const calculateSquareArea = () => {
    const area = Math.pow(squareSide, 2);
    setAreaResult(`Square Area: ${area.toFixed(2)}`);
  };

  const magicSum = (number) => {
    console.log(
      `%c ${number} `,
      "background: #222; color: #bada55; font-size: 20px;",
    );
  };

  return (
    <div className="container">
      <div className="calculator">
        <div className="display">
          <input type="text" value={input} readOnly />
          <div className="result">{result}</div>
        </div>
        <div className="buttons">
          <button onClick={() => handleClick("1")}>1</button>
          <button onClick={() => handleClick("2")}>2</button>
          <button onClick={() => handleClick("3")}>3</button>
          <button onClick={() => handleClick("4")}>4</button>
          <button onClick={() => handleClick("5")}>5</button>
          <button onClick={() => handleClick("6")}>6</button>
          <button onClick={() => handleClick("7")}>7</button>
          <button onClick={() => handleClick("8")}>8</button>
          <button onClick={() => handleClick("9")}>9</button>
          <button onClick={() => handleClick("0")}>0</button>
          <button onClick={() => handleClick("+")}>+</button>
          <button onClick={() => handleClick("-")}>-</button>
          <button onClick={() => handleClick("*")}>*</button>
          <button onClick={() => handleClick("/")}>/</button>
          <button onClick={handleClear}>C</button>
          <button onClick={handleCalculate}>=</button>
          <button onClick={() => magicSum(input)}>don't click me</button>
        </div>
      </div>
      <div className="area-calculator">
        <h3>Area Calculator</h3>
        <div>
          <label htmlFor="circleRadius">Circle Radius:</label>
          <input
            id="circleRadius"
            type="number"
            value={circleRadius}
            onChange={(e) => setCircleRadius(e.target.value)}
          />
          <button onClick={calculateCircleArea}>Calculate Circle Area</button>
        </div>
        <div>
          <label htmlFor="triangleBase">Triangle Base:</label>
          <input
            id="triangleBase"
            type="number"
            value={triangleBase}
            onChange={(e) => setTriangleBase(e.target.value)}
          />
          <label htmlFor="triangleHeight">Triangle Height:</label>
          <input
            id="triangleHeight"
            type="number"
            value={triangleHeight}
            onChange={(e) => setTriangleHeight(e.target.value)}
          />
          <button onClick={calculateTriangleArea}>
            Calculate Triangle Area
          </button>
        </div>
        <div>
          <label htmlFor="squareSide">Square Side:</label>
          <input
            id="squareSide"
            type="number"
            value={squareSide}
            onChange={(e) => setSquareSide(e.target.value)}
          />
          <button onClick={calculateSquareArea}>Calculate Square Area</button>
        </div>
        <div className="area-result">{areaResult}</div>
      </div>
    </div>
  );
};

export default Calculator;
