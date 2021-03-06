import React from "react";
import { Redirect } from "react-router"
import Login from "./Login";
import SignUp from "./SignUp"
import UserContext from "./Contexts/UserContext";
import { useContext } from "react";

const LoginRedirect = (props) => {
  const { currUser } = useContext(UserContext);

  return(
    currUser ? <Redirect to="/home" /> : <Login /> 
  )
};

const SignupRedirect = (props) => {
  const { currUser } = useContext(UserContext);

  return(
    currUser ? <Redirect to="/home" /> : <SignUp /> 
  )
}

export { LoginRedirect, SignupRedirect }