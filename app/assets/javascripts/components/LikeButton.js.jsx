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
      button = (<span className='error'>{self.state.errors[item.id]}</span>);
    } else {
      button = (
        <span>
          <i id={self.props.id} className={self.likeButtonClass()} onClick={self.props.handleClick}></i>{self.props.totalLikes}
        </span>
      );
    }
    return (
        <span>
          {button}
        </span>
    );
  }
})