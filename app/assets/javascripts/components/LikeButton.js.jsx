var LikeButton = React.createClass({
  likeButtonClass: function(){
    if (this.props.liked) {
      return 'fa fa-heart fa-3x';
    } else {
      return 'fa fa-heart-o fa-3x';
    }
  },
  render: function(){
    var self = this;
    var button;
    if (self.props.errors) {
      button = (<span className='error'>You must be logged in to vote</span>);
    } else {
      button = (
        <span>
          <i id={self.props.id} className={self.likeButtonClass()} onClick={self.props.handleClick}></i>{self.props.totalLikes}
        </span>
      );
    }
    return (
      <div className="columns large-2 medium-2 small-2">
        <span>
          {button}
        </span>
      </div>
    );
  }
})