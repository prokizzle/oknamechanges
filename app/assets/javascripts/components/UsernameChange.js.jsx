var UsernameChange = React.createClass({
  getDefaultProps: function(){
    return {
      likes: {},
      like: function(){},
      likeButtonClass: function(){},
      errors: {}
    };
  },
  render: function(){
    var self = this;
    var feedItems = this.props.changes.map(function(item, i){
      return (
          <div>
            <NameChange item={item} index={i}/>
            <LikeButton
              totalLikes={+item.likes + self.state.likes[item.id] ? 1 : 0}
              liked={self.state.likes[item.id]}
              errors={self.props.errors[item.id]}/>
          </div>
      );
    });

    return (
      <div>
        {feedItems}
      </div>
    );
  }
});