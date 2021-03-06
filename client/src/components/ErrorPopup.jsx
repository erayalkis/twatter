import React from 'react'
import { useState } from "react";
import { Alert } from "react-bootstrap";

const ErrorPopup = (props) => {
  const [show, setShow] = useState(true);
  const handleClose = () => setShow(false);
  const { error } = props;

  return(
    <Alert className="w-50 mx-auto" variant="danger" show={show} onClose={handleClose} dismissible>
      {error}
    </Alert>
  )
};

export default ErrorPopup;
