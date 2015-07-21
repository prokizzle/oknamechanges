var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var NameChangeFeed = React.createClass({
  getInitialState: function(){
    return {
      nameChanges: new FixedQueue(10, []),
      likes: {},
      errors: {}
    };
  },
  componentDidMount: function(){
    this.pollForNameChanges();
  },
  pollForNameChanges: function(){
    var self = this;
    setTimeout(function(){
        var changes = self.state.nameChanges;
      $.get('/api/random-name-change', function(data){
        changes.unshift(data);
        self.setState({
          nameChanges: changes
        });
        console.log(self.state.nameChanges);
        self.pollForNameChanges();
      });
    }, 5000);
  },
  like: function(e){
    var id = e.currentTarget.id;
    var likes = this.state.likes;
    var errors = this.state.errors;
    var self = this;
    likes[id] = true;
    $.post('/api/upvote', {
      id: id
    }).done(function(){
      self.setState({likes: likes});
    }).fail( function(xhr, textStatus, errorThrown) {
      errors[id] = 'You must be logged in to vote!';
      self.setState({errors: errors});
    });
  },
  likeButtonClass: function(id){
    if (this.state.likes[id]) {
      return 'fa fa-heart fa-3x';
    } else {
      return 'fa fa-heart-o fa-3x';
    }
  },
  render: function(){
    var classes;
    var self = this;
    if (this.state.nameChanges.length) {
      var feedItems = this.state.nameChanges.map(function(item, i){
      if (self.state.errors[item.id]) {
        var likeButton = (<span className='error'>{self.state.errors[item.id]}</span>);
      } else {
        var likeButton = (
           <span>
             <i id={item.id} className={self.likeButtonClass(item.id)} onClick={self.like}></i>{+item.likes + (self.state.likes[item.id] ? 1 : 0)}
           </span>
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
    } else {
      var feedItems = <div className='loading'>Loading...</div>;
    };

    return (
      <div className='row'>
        <ReactCSSTransitionGroup transitionName="example">
            {feedItems}
        </ReactCSSTransitionGroup>
      </div>
    );
  }
});
