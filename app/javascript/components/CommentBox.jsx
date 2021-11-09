import React, { useState } from "react";
import { Button } from "react-bootstrap";


const CommentBox = (props) => {
  
  const [body, setBody] = useState("")

  const handleSubmit = (e) => {
    e.preventDefault();
    
    const CSRF = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    const data ={
      comment: {
        "user_id": current_user.id,
        "post_id": props.post_id,
        "body": body
      }
    }

    fetch('/comments', {
      method: 'POST',        
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': CSRF
      },
      body: JSON.stringify(data)
    });
  };

  return(
    <div className="card col-md-6 mt-1">
      <form onSubmit={handleSubmit}>
        <textarea value={body} onChange={(e) => setBody(e.currentTarget.value) } className="form-control" style={{resize:"none"}} placeholder="Make a comment"></textarea>
        <p>{body.length}/250</p>
        <Button type="submit" disabled={body.length > 250 || body.length == 0} className="m-1">Twat</Button>
      </form>
    </div>
  );
};

export default CommentBox;