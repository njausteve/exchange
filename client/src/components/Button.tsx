import React from "react";

interface ButtonProps {
  isFetching: boolean;
  onClick: () => void;
}

const Button: React.FC<ButtonProps> = ({ isFetching, onClick }) => {
  return (
    <button
      type="button"
      className="align-srelative inline-flex items-center gap-x-1.5 rounded-md bg-indigo-500 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
      disabled={isFetching}
      onClick={onClick}
      style={{ cursor: "pointer" }}
    >
      Show Latest
    </button>
  );
};

export default Button;
