import React from "react";
import { Link} from "react-router-dom";
import { Button } from "react-bootstrap";

const Comment = (props) => {


  const handleDelete = () => {

    fetch(`https://twatter-backend-api.herokuapp.com/comments/${props.comment.id}`, {
      method: 'DELETE',      
      headers: {
        'Content-Type': 'application/json',
      },
    })

    props.setComments(oldComm => oldComm.filter(comment => comment.id !== props.comment.id));
  };

  return(
    <div className="row justify-content-center">
      <div className="card col-md-6 m-4">
        <img src={props.comment.image} alt="Commenter" className="w-25" />
        <h3><Link style={{textDecoration:"none"}} to={`/user/${props.comment.user_id}`}>@{props.comment.poster}</Link></h3>
        <h3>{props.comment.body}</h3>

        <Button className="m-1" onClick={handleDelete}>Delete Comment</Button>
      </div>
    </div>
  )
};

export default Comment;