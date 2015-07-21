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
      var likeButton
      if (self.props.errors[item.id]) {
        likeButton = (<span className='error'>{self.props.errors[item.id]}</span>);
      } else if (self.props.votes) {
        likeButton = (
           <LikeButton
              totalLikes={+item.likes + self.state.likes[item.id] ? 1 : 0}
              liked={self.state.likes[item.id]}
              errors={self.props.errors[item.id]}/>
        );
      }
        var newNames = item.new_names.map(function(name){
          return (
            <span>
              <span className='became'>became</span>
              <span className='newName'>{name}</span>
            </span>
          );
        });
        if (i == 0) {
          classes = 'panel first columns large-10 medium-10 small-10';
        } else {
          classes = 'panel latter columns large-10 medium-10 small-10';
        }
        return (
            <div>
              <div className={classes} id={item.id}>
                <span className='oldName'>{item.old_name}</span>{newNames}
              </div>
              <div className="columns large-2 medium-2 small-2">
                {likeButton}
              </div>
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